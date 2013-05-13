class FeedJob
	@queue = :feeds_queue
	def self.perform(channel_id)
		channel = Channel.find(channel_id)
		channel.feed.update_from_feed(channel.url)
		channel.save
		puts "Feeds are added in " + channel_id.to_s  
	end
end