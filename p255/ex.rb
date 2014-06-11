module Enumerable
	def classify(&block)
		hash = {}
		self.each do |x|
			result = block.call(x)
			(hash[result] ||= []) << x
		end
		hash
	end
end

print "Insert ' '-delimited array: "
array  = gets.chomp.split(' ')
print "Insert classification method (x-variable): "
meth = gets.chomp
res = array.classify {|x| eval(meth)}

puts "\tResult:\n"
res.each do |k,v|
	print "\n\t\tClass '#{k}':\t"
	print v.join(", ")
end