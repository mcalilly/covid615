class Update < ApplicationRecord
  include HTTParty

  belongs_to :county

  after_save  :calculate_total_cases
  after_save  :calculate_new_cases_growth_rate
  after_save  :calculate_total_cases_growth_rate
  after_save  :calculate_total_deaths
  after_save  :calculate_average_death_rate

  validates :date, uniqueness: true

  private

    def calculate_total_cases
      updates_through_today = Update.where(date: 100.years.ago..self.date)
      total_cases_through_today = updates_through_today.sum(:new_cases).to_f
      self.update_columns(total_cases: total_cases_through_today)
    end

    def calculate_total_deaths
      updates_through_today = Update.where(date: 100.years.ago..self.date)
      total_deaths_through_today = updates_through_today.sum(:new_deaths).to_f
      self.update_columns(total_deaths: total_deaths_through_today)
    end

    def calculate_average_death_rate
      updates_through_today = Update.where(date: 100.years.ago..self.date)
      total_cases_through_today = updates_through_today.sum(:new_cases).to_f
      total_deaths_through_today = updates_through_today.sum(:new_deaths).to_f
      current_average_death_rate = total_deaths_through_today / total_cases_through_today
      self.update_columns(average_death_rate: current_average_death_rate)
    end

    def calculate_new_cases_growth_rate
      current_update  = Update.where(date: self.date)
      previous_update = Update.where(date: self.date-1.day)
      next_update     = Update.where(date: self.date+1.day)

      current_update_new_cases  = current_update.sum(:new_cases).to_f
      previous_update_new_cases = previous_update.sum(:new_cases).to_f
      next_update_new_cases = next_update.sum(:new_cases).to_f

      current_update_case_growth_rate = (current_update_new_cases - previous_update_new_cases) / previous_update_new_cases
      next_update_cases_growth_rate = (next_update_new_cases - current_update_new_cases) / current_update_new_cases

      if previous_update.present? && next_update.empty?
        if current_update_new_cases == 0 || previous_update_new_cases == 0
          self.update_columns(new_cases_growth_rate: nil)
        else
          self.update_columns(new_cases_growth_rate: current_update_case_growth_rate)
        end
      end

      if next_update.present? && previous_update.present?
        if current_update_new_cases == 0
          self.update_columns(new_cases_growth_rate: nil)
          next_update.update_all(new_cases_growth_rate: nil)
        elsif current_update_new_cases > 0 && next_update_new_cases == 0
          self.update_columns(new_cases_growth_rate: current_update_case_growth_rate)
          next_update.update_all(new_cases_growth_rate: nil)
        else
          self.update_columns(new_cases_growth_rate: current_update_case_growth_rate)
          next_update.update_all(new_cases_growth_rate: next_update_cases_growth_rate)
        end
      end

      if next_update.present? && previous_update.empty?
        if current_update_new_cases == 0 || next_update_new_cases == 0
          self.update_columns(new_cases_growth_rate: nil)
          next_update.update_all(new_cases_growth_rate: nil)
        else
          self.update_columns(new_cases_growth_rate: nil)
          next_update.update_all(new_cases_growth_rate: next_update_cases_growth_rate)
        end
      end
    end

    def calculate_total_cases_growth_rate
      current_update  = Update.where(date: self.date)
      previous_update = Update.where(date: self.date-1.day)
      next_update     = Update.where(date: self.date+1.day)

      current_update_total_cases  = current_update.sum(:total_cases).to_f
      previous_update_total_cases = previous_update.sum(:total_cases).to_f
      next_update_total_cases = next_update.sum(:total_cases).to_f

      current_update_total_cases_growth_rate = (current_update_total_cases - previous_update_total_cases) / previous_update_total_cases
      next_update_total_cases_growth_rate = (next_update_total_cases - current_update_total_cases) / current_update_total_cases

      if previous_update.present? && next_update.empty?
        if current_update_total_cases == 0
          self.update_columns(total_cases_growth_rate: nil)
        else
          self.update_columns(total_cases_growth_rate: current_update_total_cases_growth_rate)
        end
      end

      if next_update.present? && previous_update.present?
        if current_update_total_cases == 0
          self.update_columns(total_cases_growth_rate: nil)
          next_update.update_all(total_cases_growth_rate: nil)
        elsif current_update_total_cases > 0 && next_update_total_cases == 0
          self.update_columns(total_cases_growth_rate: current_update_total_cases_growth_rate)
          next_update.update_all(total_cases_growth_rate: nil)
        else
          self.update_columns(total_cases_growth_rate: current_update_total_cases_growth_rate)
          next_update.update_all(total_cases_growth_rate: next_update_total_cases_growth_rate)
        end
      end

      if next_update.present? && previous_update.empty?
        if current_update_total_cases == 0 || next_update_total_cases == 0
          self.update_columns(total_cases_growth_rate: nil)
          next_update.update_all(total_cases_growth_rate: nil)
        else
          self.update_columns(total_cases_growth_rate: nil)
          next_update.update_all(total_cases_growth_rate: next_update_total_cases)
        end
      end
    end
end
