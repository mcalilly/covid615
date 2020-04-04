# Next Steps

* Calculate total cases per day based on sum of all previous updates. Save this as an attribute on update. It should calculate after_commit when any update today or prior gets updated.
* Calculate total cases growth rate per day based on the previous day's total cases. Should re-calculate if the current update or previous update changes.
* Display total cases and total case change rates on the county show page
* Forward covid615.com to the Davidson county
* Use chart.js to chart new cases, total cases and deaths
* Add login and pundit so that only someone with an admin account can edit data
* Create a background job that grabs the data from Johns Hopkins via the api at misssissippicovid.com


## Ideas for features
* Create a "City" scaffold that allows you to associate counties with cities. For Nashville, it would just be Davidson county, but a city like Atlanta might have many associated counties.
* Create dashboard pages similar to county pages for states (use FIPS to associate them?)
