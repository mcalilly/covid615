# Notes
* run `rake fetch_update:nashville` to pull the updates manually. (This should be handled daily at 10:00am CST by Heroku Scheduler)
* run `rake daily_updates:manually_send_subscriber_emails` to manually send the latest update to all subscribers.
* run `rake daily_updates:send_todays_update` to pull test sending the admin mailer when there's not a new update (this is scheduled for 11am CST).

# How to download the latest data from production to local db
* heroku pg:backups:capture
* heroku pg:backups:download
* pg_restore --verbose --clean --no-acl --no-owner -h localhost -d coronavirus_development latest.dump
* rails db:migrate
* then optionally delete the "latest.dump" file in the root directory

# Next Steps
* Create a mailer to send admins warnings if something hasn't posted
  - Simplest way might be a rake task that triggers a mailer to admin at 11am if there is not an update today (if Update.last date != today, etc.)

* Set up a subscriber email list that sends a daily update mailer with the latest numbers
  - possible to embed a graph into this as well?

## Ideas for features
* Include 7 day moving averages on charts (at least new cases)
