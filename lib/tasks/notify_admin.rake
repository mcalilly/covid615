namespace :fetch_update do

  desc "send a warning to admin if today's update isn't saved"
  task notify_admin: :environment do

    latest_update = Update.last

    if latest_update.date.strftime("%B %e, %Y") != Time.now.in_time_zone("Central Time (US & Canada)").strftime("%B %e, %Y")
      puts "Warning: today's update was not saved."
      AdminMailer.no_update.deliver_now
    else
      success_message = "Today's update was saved successfully!"
      puts "#{success_message}"
      Rails.logger.info "#{success_message}"
      AdminMailer.update_posted.deliver_now
    end
  end

end
