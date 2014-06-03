x = 1000001.0 / 0.003
y = x * 0.003
puts "Before: "
puts y == 1000001.0 ? "yes (#{y} = 1000001.0)" : "no (#{y} <> 1000001.0)"

class Float
	EPS = 1e-6
	def ==(x)
		(self-x).abs < EPS ? true : false
	end
end

puts "After: "
puts y == 1000001.0 ? "yes (#{y} = 1000001.0)" : "no (#{y} <> 1000001.0)"