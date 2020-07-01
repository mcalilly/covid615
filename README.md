# Notes
* run `heroku run rake fetch_update:nashville` to pull the updates manually. (This should be handled daily at 10:30am CST by Heroku Scheduler)

# Next Steps
* Create a mailer to send admins warnings if something hasn't posted
  - Simplest way might be a rake task that triggers a mailer to admin at 11am if there is not an update today (if Update.last date != today, etc.)

* Set up a subscriber email list that sends a daily update mailer with the latest numbers
  - possible to embed a graph into this as well?

## Ideas for features
* Include 7 day moving averages on charts (at least new cases)
