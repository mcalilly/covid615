class Update < ApplicationRecord
  default_scope { order(date: :desc) }

  after_commit :calculate_case_growth_rate
  # after_commit :calculate_daily_death_growth_rate

  belongs_to :county
  validates :date, uniqueness: true

  private

    def calculate_case_growth_rate
      current_update  = Update.where(date: self.date)
      previous_update = Update.where(date: self.date-1.day)
      next_update     = Update.where(date: self.date+1.day)

      current_update_cases  = current_update.sum(:cases).to_f
      previous_update_cases = previous_update.sum(:cases).to_f
      current_update_case_growth_rate = ((current_update_cases - previous_update_cases) / previous_update_cases) * 100
      self.update_columns(case_growth_rate: current_update_case_growth_rate)

      if next_update.present?
        next_update_cases = next_update.sum(:cases).to_f
        next_update_case_growth_rate = ((next_update_cases - current_update_cases) / current_update_cases) * 100
        self.next_update.update_columns(case_growth_rate: next_update_case_growth_rate)
      end
    end

    def calculate_daily_death_growth_rate
      # do math to calculate daily death growth rate
    end
end
