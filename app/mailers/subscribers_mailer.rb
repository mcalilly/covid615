class SubscribersMailer < ApplicationMailer

  def send_daily_updates(subscriber)

    # Set up variables used in the mailer view
    @todays_update = Update.last
    @yesterdays_update = Update.where(date: @todays_update.date-1.day)

    @todays_cases = @todays_update.new_cases
    @yesterdays_cases = @yesterdays_update.sum(:new_cases)
    @new_deaths = @todays_update.new_deaths
    @total_deaths = @todays_update.total_deaths

    # Send the email
    mail(to: subscriber.email, subject: "Covid-19 Daily Update for Nashville • #{Time.now.in_time_zone("Central Time (US & Canada)").strftime("%b %e")}")
  end

end
