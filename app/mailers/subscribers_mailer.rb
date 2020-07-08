class SubscribersMailer < ApplicationMailer

  def send_daily_updates
    @subscribers = Subscriber.all

    @todays_update = Update.last
    @yesterdays_update = Update.where(date: @todays_update.date-1.day)

    @todays_cases = @todays_update.new_cases
    @yesterdays_cases = @yesterdays_update.sum(:new_cases)
    @new_deaths = @todays_update.new_deaths
    @total_deaths = @todays_update.total_deaths

    @subscribers.each do |subscriber|
      mail(to: subscriber.email, subject:  "#{Time.now.in_time_zone("Central Time (US & Canada)").strftime("%B %e, %Y")} • Covid-19 Daily Update for Nashville, TN")
    end
  end

end
