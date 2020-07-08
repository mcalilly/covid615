namespace :subscribers do
  desc "send all subscribers a daily update with the latest Covid-19 numbers"
  task send_daily_updates: :environment do
    @success_message = "Update for #{Date.today.strftime("%a, %e %b %Y")} was sent to subscribers."
    puts "#{@success_message}"
    Rails.logger.info "#{@success_message}"
    SubscribersMailer.send_daily_updates.deliver_now
  end
end
