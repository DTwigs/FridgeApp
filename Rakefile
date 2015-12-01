# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :fridge_app do
  task temperature_alert: :environment do
    puts "Started temperature alert task"
    message = ::Message.new("")
    temp_checker = ::TempChecker.new(message)
    temp_checker.perform
    puts "End temperature alert task"
  end

end
