require 'rss'

# 2.0 OR atom
rss_type = "atom"
rss_version = (rss_type == "atom" ? "atom" : "2.0")

feed = RSS::Maker.make(rss_type) do |maker|
	maker.channel.language = "ru"
	maker.channel.author = "Cema"
	maker.channel.title = "My Own Feed"
	maker.channel.description = "Made it Myself"
	maker.channel.link = "http://cema.net63.net/"
	maker.channel.id = "01"
	maker.channel.updated = Time.now.to_s

=begin
	maker.image do |image|
		image.url = "http://whatweekly.com/wp-content/uploads/2013/12/3rubys2-300x224.jpg"
		image.title = "Cema"
		image.link = channel.link
	end
=end

	maker.items.new_item do |item|
		item.title = "Here I Am"
		item.link = "http://cema.net63.net/1"
		item.description = "Description of new article"
		item.id = "11"
		item.author = "Cema"
		item.updated = Time.now.to_s
	end
	maker.items.new_item do |item|
		item.title = "Wow! Second One"
		item.link = "http://cema.net63.net/2"
		item.description = "Great achievment"
		item.id = "12"
		item.author = "Cema"
		item.updated = Time.now.to_s
	end
	maker.items.new_item do |item|
		item.title = "Try to Guess"
		item.link = "http://cema.net63.net/2"
		item.description = "I'm still here"
		item.id = "13"
		item.author = "Cema"
		item.updated = Time.now.to_s
	end
end

File.open(File.expand_path(File.dirname(__FILE__))+
	"/my.rss","w+") do |file|
	file << feed.to_feed(rss_type)
end