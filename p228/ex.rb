# arr[x,y] == arr[y,x]
class TriMatrix
	def initialize
		@matrix = []
	end
	def [](x,y)
		a = [x,y].max
		b = [x,y].min
		@matrix[(a**2+a)/2 + b]
	end
	def []=(x,y,v)
		a = [x,y].max
		b = [x,y].min
		@matrix[(a**2+a)/2 + b] = v
	end
end

t = TriMatrix.new
t[3,2] = 11
t[4,4] = 12
t[2,1] = 13

puts "t[3,2] = #{t[3,2]} = #{t[2,3]}"
puts "t[4,4] = #{t[4,4]}"
puts "t[2,1] = #{t[2,1]} = #{t[1,2]}"
