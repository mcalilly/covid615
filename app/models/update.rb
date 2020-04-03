class Update < ApplicationRecord
  default_scope { order(date: :desc) }

  before_save :calculate_case_growth_rate
  # after_commit :calculate_daily_death_growth_rate

  belongs_to :county
  validates :date, uniqueness: true

  private

    def calculate_case_growth_rate
      current_cases  = self.cases
      previous_cases = Update.where(date: 1.day.ago).sum(:cases)
      self.case_growth_rate = (current_cases - previous_cases) / current_cases
    end

    def calculate_daily_death_growth_rate
      # do math to calculate daily death growth rate
    end
end

# current_update  = Update.last
# current_cases   = current_update.cases
# previous_update = Update.where(date: 1.day.ago)
# previous_cases  = previous_update.pluck(:cases).join.to_i
# Update.where(date: Update.last.date-1.day)
