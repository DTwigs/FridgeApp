# FridgeApp

FridgeApp is a Rails program that helps monitor our refridgerator's temperature. Data from a sensor in our fridge gets sent to our API, which stores the data. The web app uses React JS to display the data and poll for new data. There is a scheduled job that runs every 10 minutes that sends us a text message if the temperature in our fridge gets too high, or if no data has been received for the past 30 minutes.

## Demo

http://fridge-app.herokuapp.com/

## Why?

Our refridgerator is kind of terrible. Sometimes the door doesn't completely seal and the fridge heats up. Since we don't want to throw away all of our food every other week, we wrote a program to monitor and notify us when we should check our fridge to make sure the door is completely closed or whatever else might be causing it to heat up.

## Technologies and Tools

Ruby on Rails, React JS, Twilio, Heroku Scheduler, Rake tasks, Moment.js, RSpec, Postgres.
