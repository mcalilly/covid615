namespace :subscribers do
  desc "send all subscribers a daily update with the latest Covid-19 numbers"
  task send_daily_updates: :environment do
      SubscriberMailer.send_daily_updates.deliver_now
  end
end
