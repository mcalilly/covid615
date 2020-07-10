namespace :daily_updates do

  desc "send all subscribers a daily update with the latest Covid-19 numbers"
  task send_subscriber_emails: :environment do

    Subscriber.find_each do |subscriber|
      SubscribersMailer.send_daily_updates(subscriber).deliver_now
    end

    @success_message = "Update for #{Date.today.strftime("%a, %e %b %Y")} was sent to subscribers."
    puts "#{@success_message}"
    Rails.logger.info "#{@success_message}"
  end
end
