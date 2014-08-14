require 'rexml/document'
require 'rexml/streamlistener'
include REXML

class MyListener
	include REXML::StreamListener
	def tag_start(*args)
		puts "Tag Start: #{args.map{|x| x.inspect}.join(', ')}"
	end

	def text(data)
		# return if only spaces present
		return if data =~ /^\w*$/
		abbrev = data[0..40] + (data.length > 40 ? "..." : "")
		puts "\ttext: #{abbrev.inspect}"
	end
end

list = MyListener.new
source = File.new(File.expand_path(File.dirname(__FILE__))+
				"/books.xml")
Document.parse_stream(source, list)