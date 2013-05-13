#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'thinking_sphinx/deltas/datetime_delta/tasks'

RSSFeedsReadSystem::Application.load_tasks

namespace :reader do
  desc 'Grab the latest feeds'
  task :update => :environment do
    Channel.all.each do |channel|
    	puts "id" + channel.id.to_s
    	puts "before:" + channel.feed.all.count.to_s 
    	channel.feed.update_from_feed(channel.url)
    	puts "after :" + channel.feed.all.count.to_s
  	end
  end
end


