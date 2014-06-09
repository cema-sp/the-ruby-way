# encoding: utf-8

require 'mathn'

class Formula
	def initialize str
		if /[x\d+\-*\/)(]+/ =~ str
			@formula = str
		else
			raise ArgumentError, "Enter valid formula!"
		end
	end
	def on x
		begin
			#puts "formula=#{@formula.gsub('x',x.to_f.to_s)}"
			eval(@formula.gsub('x',x.to_f.to_s))
		rescue
			warn "Wrong formula"
		end
	end
end

class Integral
	def initialize formula
		@formula = formula
	end
	
	def calculate a,b,prec = 1000
		dx = (b-a)/1000.0
		x = a+dx/2.0
		sum = 0
		while x<b
			sum+=@formula.on(x)*dx
			x+=dx
		end
		sum
	end
end

class GraphPlot
	
	BLACK = "\u2588"
	WHITE = " "
	HORIZONTAL = "\u2500"
	VERTICAL = "\u2502"
	CONNER = "\u2514"

	def initialize formula
		@formula = formula
	end
	
	def plot a,b,width=40
		step = (b-a)/width.to_f
		x = a
		
		canvas = Array.new width
		max_h = 0
		max_v = 0
		min_v = 0
		
		canvas.each_index do |i|
			value = (@formula.on(x)+@formula.on(x+step))/2.0
			#puts "on x=#{x.to_f}-#{(x+step).to_f} v=#{value.to_f}"
			h = (value/step).ceil.to_i
			max_h = [max_h, h].max
			max_v = [max_v,value].max.to_f
			min_v = [min_v,value].min.to_f
			canvas[i] = Array.new(h, 1)
			x+=step
		end
		
		#p canvas
		#puts "Max_h=#{max_h}"
		#puts "Max_v=#{max_v}"
		#puts "Min_v=#{min_v}"
		
		y_size = max_v.round.size
		puts "%#{y_size}.1f" % max_v		#top value
		
		max_h.downto(0) do |i|
		
			(y_size+1).times {print ' '}	#for spaces
			print VERTICAL					#for axis
			
			canvas.each do |canvas_col|
				if canvas_col[i].nil?
					print WHITE
				else
					print BLACK
				end
			end
			puts ''
		end
		
		(y_size+1).times {print ' '}		#for spaces
		print CONNER						#left bottom conner
		canvas.size.times {print HORIZONTAL}#for spaces
		puts ''								#next line
		print "%#{y_size}.1f" % min_v		#bottom value
		(canvas.size+2).times {print ' '}		#for spaces
		puts b								#last value
		
		
	end	
end

print "Type a formula: y="
formula = Formula.new gets.chop

print "Boundaries (' '-delimited): "
a,b = gets.chop.split(' ')
print "Graph width: "
w = gets.chop.to_i

integral = Integral.new formula
graph = GraphPlot.new formula
puts "Integral from #{a} to #{b}: INT(#{a},#{b})=#{"%-8.3f" % integral.calculate(a.to_f,b.to_f)}"

graph.plot a.to_i,b.to_i,w.to_i
