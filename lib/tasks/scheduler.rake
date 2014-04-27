desc "This task is called by the Heroku scheduler add-on"
task :daily_roll_call => :environment do
  puts "Sending daily roll call reminders..."
  User.daily_roll_call
  puts "done."
end
