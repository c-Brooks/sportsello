# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# RUN THESE COMMANDS IF YOU MAKE CHANGES

# UPDATE CRON
# whenever --update-crontab

# RESTART CRON
# sudo service cron restart

set :output, "/vagrant/projects/sportsello/log/scheduler.log"
set :environment, 'development'

# Download games frequently in case of mistakes
every 5.hours do
  runner 'GetGames.new.crawl'
end

# Clean up expired games
every 1.day do
  runner 'CleanGames.new.clean'
end
