job_type :rake, 'cd :path && RAILS_ENV=:environment PATH=/usr/local/bin:/usr/bin:/bin /usr/local/bin/bundle exec rake :task --silent :output'
set :output, 'log/cron.log'

every 1.day do
  rake 'infopark:cache:gc'
end
