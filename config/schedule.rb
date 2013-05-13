set :environment, :development

every 20.minutes do
  rake "reader:update"
end

every 2.minutes do
	rake "resque:work QUEUE='*'"
end

every :day, :at => '6:30 pm' do
	runner "User.last_feeds"
end

every :reboot do
	rake "thinking_sphinx:stop"
	rake "thinking_sphinx:index"
	rake "thinking_sphinx:start"
	rake "resque:work QUEUE='*'"
end
