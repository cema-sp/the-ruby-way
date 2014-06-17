class ZArray < Array
	def [](x)
		if x > size
			for i in size+1..x
				self[i]=0
			end
		end
		v = super(x)
	end
	
	def []=(x,v)
		pr_size = size
		super(x,v)
		
		if size - pr_size > 1
			(pr_size..size-2).each do |i|
				self[i] = 0
			end
		end
	end
end
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

# triangle matrix with ZArray
class LowerMatrix < TriMatrix
	def initialize
		# just empty array
		@matrix = ZArray.new
	end
end

class Graph
	def initialize(*edges)
		@store = LowerMatrix.new
		@max = 0
		for e in edges
			#e[0], e[1] = e[1], e[0] if e[1] > e[0]
			@store[e[0],e[1]] = 1
			@max = [@max, e[0], e[1]].max
		end
	end
	
	def [](x,y)
		#if x>y
		#	@store[x,y]
		#elsif x<y
		#	@store[y,x]
		#else
		#	0
		#end
		if x==y
			0
		else
			@store[x,y]
		end
	end
	def []=(x,y,v)
		#if x>y
		#	@store[x,y]=v
		#elsif x<y
		#	@store[y,x]=v
		#else
		#	0
		#end
		if x==y
			0
		else
			@store[x,y]=v
		end
	end
	def edge?(x,y)
		#x,y = y,x if x<y
		@store[x,y]==1
	end
	def add(x,y)
		@store[x,y]=1
	end
	def remove(x,y)
		#x,y = y,x if x<y
		@store[x,y]=0
		if (degree @max) == 0
			@max-=1
		end
	end
	def vmax
		@max
	end
	def degree(x)
		sum=0
		0.upto @max do |i|
			sum+=self[x,i]
		end
		sum
	end
	def each_vertex
		(0..@max).each {|v| yield v}
	end
	def each_edge
		for v0 in 0..@max
			for v1 in 0..v0-1
				yield v0,v1 if self[v0,v1]==1
			end
		end
	end
	def connected?
		x = vmax
		k = [x]
		l = [x]
		for i in 0..@max
			l << i if self[x,i]==1
		end
		until k.empty?
			y=k.shift
			self.each_edge do |a,b|
				if a==y || b==y
					z = a==y ? b : a
					unless l.include? z
						l << z
						k << z
					end
				end
			end
		end
		if l.size < @max
			false
		else
			true
		end
	end
	def euler_circuit?
		return false unless connected?
		for i in 0..@max
			return false if degree(i) % 2 != 0
		end
		true
	end
	def euler_path?
		return false unless connected?
		odd = 0
		each_vertex do |x|
			odd += 1 if degree(x) % 2 == 1
		end
		odd <= 2
	end
end

mygraph = Graph.new([1,0],[0,3],[2,1],[3,1],[3,2])

mygraph.each_vertex {|v| puts mygraph.degree(v)}
mygraph.each_edge {|a,b| puts "(#{a},#{b})"}
puts mygraph.connected? ? "Graph is connected" : "Graph is not connected"
puts mygraph.euler_circuit? ? "Graph with Euler Circuit" : "Graph w\/o Euler Circuit"
puts mygraph.euler_path? ? "Graph with Euler Path" : "Graph w\/o Euler Path"
puts "Removing (1,3)"
mygraph.remove(1,3)
puts mygraph.euler_circuit? ? "Graph with Euler Circuit" : "Graph w\/o Euler Circuit"
puts mygraph.euler_path? ? "Graph with Euler Path" : "Graph w\/o Euler Path"
puts "Removing (0,3)"
mygraph.remove(0,3)
puts "Removing (1,2)"
mygraph.remove(1,2)
mygraph.each_vertex {|v| puts mygraph.degree(v)}
puts mygraph.connected? ? "Graph is connected" : "Graph is not connected"
