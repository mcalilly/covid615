# Next Steps
* Write a rake task that can be run to load all of the States and Counties into the db - https://thoughtbot.com/blog/data-migrations-in-rails
* Create a background job that grabs the data from Johns Hopkins via the api at misssissippicovid.com
  1. first, get this working in the County update action
  2. then, figure out how to make it a job
* Add login and pundit so that only someone with an admin account can edit data
* Add days since first case to the dashboard page
* Set up dynamic page titles so that the page title is localized to each county and state

## Ideas for features
* Look into additional features that Jack suggested
* Create a "City" scaffold that allows you to associate counties with cities. For Nashville, it would just be Davidson county, but a city like Atlanta might have many associated counties.
* Create dashboard pages similar to county pages for states (use FIPS to associate them?)
