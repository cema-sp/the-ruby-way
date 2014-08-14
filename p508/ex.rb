require 'rss'
require 'open-uri'

URL = "http://news.yandex.ru/index.rss"
open(URL) do |h|
	resp = h.read
	result = RSS::Parser.parse(resp, false)

	puts "Channel: #{result.channel.title}"
	result.items.each_with_index do |item,i|
		i += 1
		puts "#{i}) #{item.title}"		
	end
end