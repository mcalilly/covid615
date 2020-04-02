class Update < ApplicationRecord
  before_save :calculate_case_growth_rate
  # after_commit :calculate_daily_death_growth_rate

  belongs_to :county
  validates :date, uniqueness: true

  private
    def calculate_case_growth_rate
      cases_today = self.cases
      cases_yesterday = Update.second_to_last.cases
      self.case_growth_rate = (cases_today - cases_yesterday) / cases_yesterday
    end

    def calculate_daily_death_growth_rate
      # do math to calculate daily death growth rate
    end
end
