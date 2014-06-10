# linked arrays sort

class Array
	def sort_index
		d = []
		self.each_with_index {|x,i| d[i]=[x,i]}
		if block_given?
			d.sort {|x,y| yield x[0],y[0]}.map{|x| x[1]}
		else
			d.sort.map{|x| x[1]}
		end
	end
	
	def sort_with(ord=[])
		return nil if self.length!=ord.length
		self.values_at(*ord)
	end
end

class FArray < Array
	def [](x)
		if x > size
			for i in size+1..x
				self[i]='fuuu'
			end
		end
		v = super(x)
	end
	
	def []=(x,v)
		pr_size = size
		super(x,v)
		
		if size - pr_size > 1
			(pr_size..size-2).each do |i|
				self[i] = 'fuuu'
			end
		end
	end
end

print "Insert Array 1: "
arr1 = gets.chomp.split(' ')
print "Insert Array 2: "
arr2 = gets.chomp.split(' ')
s_i_1 = arr1.sort_index
print "Array 1 with index of Array 1: "
p arr1.sort_with(s_i_1)
print "Array 2 with index of Array 1: "
p arr2.sort_with(s_i_1)

num = FArray.new
num [1] = 1
num [2] = 2
puts "num[5] = #{num[5]}"
p num