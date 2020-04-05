class Update < ApplicationRecord
  default_scope { order(date: :desc) }

  after_commit :calculate_total_cases
  after_commit :calculate_daily_case_growth_rate
  after_commit :calculate_daily_death_growth_rate

  belongs_to :county
  validates :date, uniqueness: true

  private

    def calculate_total_cases
      updates_through_today = Update.where(date: 100.years.ago..self.date)
      total_cases_through_today = updates_through_today.sum(:cases).to_f
      self.update_columns(total_cases: total_cases_through_today)
    end

    def calculate_daily_case_growth_rate
      current_update  = Update.where(date: self.date)
      previous_update = Update.where(date: self.date-1.day)
      next_update     = Update.where(date: self.date+1.day)

      current_update_cases  = current_update.sum(:cases).to_f
      previous_update_cases = previous_update.sum(:cases).to_f
      next_update_cases = next_update.sum(:cases).to_f

      current_update_case_growth_rate = (current_update_cases - previous_update_cases) / previous_update_cases
      next_update_cases_growth_rate = (next_update_cases - current_update_cases) / current_update_cases

      if previous_update.present? && next_update.empty?
        if current_update_cases == 0
          self.update_columns(case_growth_rate: nil)
        else
          self.update_columns(case_growth_rate: current_update_case_growth_rate)
        end
      end

      if next_update.present? && previous_update.present?
        if current_update_cases == 0
          self.update_columns(case_growth_rate: nil)
          next_update.update_all(case_growth_rate: nil)
        elsif current_update_cases > 0 && next_update_cases == 0
          self.update_columns(case_growth_rate: current_update_case_growth_rate)
          next_update.update_all(case_growth_rate: nil)
        else
          self.update_columns(case_growth_rate: current_update_case_growth_rate)
          next_update.update_all(case_growth_rate: next_update_cases_growth_rate)
        end
      end

      if next_update.present? && previous_update.empty?
        if current_update_cases == 0 || next_update_cases == 0
          self.update_columns(case_growth_rate: nil)
          next_update.update_all(case_growth_rate: nil)
        else
          self.update_columns(case_growth_rate: nil)
          next_update.update_all(case_growth_rate: next_update_cases_growth_rate)
        end
      end
    end

    def calculate_daily_death_growth_rate
      current_update  = Update.where(date: self.date)
      previous_update = Update.where(date: self.date-1.day)
      next_update     = Update.where(date: self.date+1.day)

      current_update_deaths  = current_update.sum(:deaths).to_f
      previous_update_deaths = previous_update.sum(:deaths).to_f
      next_update_deaths = next_update.sum(:deaths).to_f

      current_update_death_growth_rate = (current_update_deaths - previous_update_deaths) / previous_update_deaths
      next_update_deaths_growth_rate = (next_update_deaths - current_update_deaths) / current_update_deaths

      if previous_update.present? && next_update.empty?
        if current_update_deaths == 0
          self.update_columns(death_growth_rate: nil)
        else
          self.update_columns(death_growth_rate: current_update_death_growth_rate)
        end
      end

      if next_update.present? && previous_update.present?
        if current_update_deaths == 0
          self.update_columns(death_growth_rate: nil)
          next_update.update_all(death_growth_rate: nil)
        elsif current_update_deaths > 0 && next_update_deaths == 0
          self.update_columns(death_growth_rate: current_update_death_growth_rate)
          next_update.update_all(death_growth_rate: nil)
        else
          self.update_columns(death_growth_rate: current_update_death_growth_rate)
          next_update.update_all(death_growth_rate: next_update_deaths_growth_rate)
        end
      end

      if next_update.present? && previous_update.empty?
        if current_update_deaths == 0 || next_update_deaths == 0
          self.update_columns(death_growth_rate: nil)
          next_update.update_all(death_growth_rate: nil)
        else
          self.update_columns(death_growth_rate: nil)
          binding.pry
          next_update.update_all(death_growth_rate: next_update_deaths_growth_rate)
        end
      end
    end
end
