# continuation usage example

require 'continuation'

class MyGenerator
	def initialize
		@names = %w[Simon Seymour Sally Sunny]
		generate
	end
	def generate
		callcc do |gen|
			@gen = gen
			return
			#@nex.call(@names.shift)
		end
		@nex.call(@names.shift)
	end
	def next
		callcc do |nex|
			@nex = nex
			@gen.call
		end
	end
end

#----------------------------

puts "Starting generator: "
g = MyGenerator.new
puts "Starting iterations: "
puts g.next
puts g.next
puts "End of program."