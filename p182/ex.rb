#require 'memoize'		#depricated
#include Memoize		#depricated

require 'memoist'
extend Memoist

def mean x
	#sum = 0
	#x.each {|v| sum += v}
	#sum/x.size
	x.inject(:+)/x.size
end
def hmean x
	#sum = 0
	#x.each {|v| sum += (1.0/v)}
	#x.size/sum
	x.size/x.inject(0.0) {|sum,v| sum+1.0/v}
end
def gmean x
	#prod = 1.0
	#x.each {|v| prod *= v}
	#prod**(1.0/x.size)
	x.inject(1,:*)**(1.0/x.size)
end
def median x
	x.sort[x.size/2]
end
def mode x
	#f = {}		#freq table
	#fmax = 0	#max freq
	#m = nil		#mode
	#x.each do |v|
	#	f[v] ||= 0
	#	f[v] += 1
	#	fmax, m = f[v], v if f[v] > fmax
	#end
	#m
	x.max_by {|v| x.count(v)}
end
def variance x
	m = mean x
	#sum = 0.0
	#x.each {|v| sum += (v-m)**2}
	#sum/x.size
	x.inject(0.0) {|sum,v| sum+(v-m)**2} / x.size
end
def sigma x
	Math.sqrt variance x
end
def correlate(x,y)
	sum = 0.0
	x.each_index do |i|
		sum += x[i]*y[i]
	end
	xymean = sum/x.size.to_f
	xmean = mean(x)
	ymean = mean(y)
	sx = sigma(x)
	sy = sigma(y)
	(xymean-(xmean*ymean))/(sx*sy)
end

def mean3 *x
	x.inject(:+)/x.size
end
def sigma3 *x
	m = mean x
	Math.sqrt(x.inject(0.0) {|sum,v| sum+(v-m)**2} / x.size)
end
def correlate3to3 *args
	x = args[0..2]
	y = args[3..5]
	sum = 0.0
	x.each_index do |i|
		sum += x[i]*y[i]
	end
	xymean = sum/x.size.to_f
	xmean = mean3(*x)
	ymean = mean3(*y)
	sx = sigma3(*x)
	sy = sigma3(*y)
	(xymean-(xmean*ymean))/(sx*sy)
end


#print "Array 1 (' '-delimited): "
#x = gets.chop.split(' ').map {|x| x.to_f}
#print "Array 1 (' '-delimited): "
#y = gets.chop.split(' ').map {|y| y.to_f}

#srand(5)		#for testing

x = []
y = []
5.times {x<<rand(9)+1}
5.times {y<<rand(9)+1}

p "x=#{x}","y=#{y}"

puts "Mean\t = #{"%3.3f" % mean(x)} \t #{"%3.3f" % mean(y)}"
puts "HMean\t = #{"%3.3f" % hmean(x)} \t #{"%3.3f" % hmean(y)}"
puts "GMean\t = #{"%3.3f" % gmean(x)} \t #{"%3.3f" % gmean(y)}"
puts "Median\t = #{"%3.3f" % median(x)} \t #{"%3.3f" % median(y)}"
puts "Mode\t = #{"%3.3f" % mode(x)} \t #{"%3.3f" % mode(y)}"
puts "Variance = #{"%3.3f" % variance(x)} \t #{"%3.3f" % variance(y)}"
puts "Sigma\t = #{"%3.3f" % sigma(x)} \t #{"%3.3f" % sigma(y)}"
puts "Correlation = #{"%3.3f" % correlate(x,y)}"

srand(5)	#for testing
time_fr = Time.now
1000000.times do
	x = []
	y = []
	3.times {x<<rand(5)+1}
	3.times {y<<rand(5)+1}
	correlate3to3(*x,*y)
end
time_to = Time.now
time_dif = (time_to-time_fr).to_f
puts "1M correlations (no memoize): #{time_dif}"

srand(5)	#for testing
memoize(:correlate3to3)
memoize(:mean3)
memoize(:sigma3)
time_fr = Time.now
1000000.times do
	x = []
	y = []
	3.times {x<<rand(5)+1}
	3.times {y<<rand(5)+1}
	correlate3to3(*x,*y)
end
time_to = Time.now
time_dif = (time_to-time_fr).to_f
puts "1M correlations (memoize): #{time_dif}"