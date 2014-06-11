#require 'enumerator'

class Foo
	def every
		yield 1
		yield 3
		yield 2
	end
end

class Bar
	def initialize(*arr)
		@a = arr
	end
	# iterates from beginning, end, beginning, end, so on
	def each
		tmp = @a.dup
		flip_flop = true
		until tmp.empty?
			if flip_flop 
				yield(tmp.shift)
			else 
				yield (tmp.pop)
			end
			flip_flop ^= true
		end
	end
end

foo = Foo.new
bar = Bar.new(1,2,3,4,5,6)

#bar.each {|x| puts x}

#foo_enum = Enumerable::Enumerator.new(foo, :every)
#bar_enum = Enumerable::Enumerator.new(bar, :each)
foo_enum = foo.to_enum(:every)
bar_enum = bar.to_enum(:each)

puts "foo to array: #{foo_enum.to_a}"
puts "foo sort: #{foo_enum.sort}"
puts "bar to array: #{bar_enum.to_a}"
puts "bar sort: #{bar_enum.sort}"