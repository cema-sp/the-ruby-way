# initialize_copy

class Document
	attr_reader :timestamp
	def initialize(title, text)
		@title, @text = title, text
		@timestamp = Time.now
	end
	
	def initialize_copy(other)
		@timestamp = Time.now
	end
end

#---------------------------------------------

d1 = Document.new("Title 1", "Text 1")
sleep 3
d2 = d1.clone

puts "d1.timestamp "+
		(d1.timestamp == d2.timestamp ? "=" : "<>")+
		" d2.timestamp"