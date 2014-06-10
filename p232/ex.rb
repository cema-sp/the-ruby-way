# subset & superset of arrays
# powerset of array
class Array
	def subset?(other)
		self.each do |x|
			if !(other.include? x)
				return false
			end
		end
		true
	end
	
	def superset?(other)
		other.subset?(self)
	end
	
	def powerset
		num = 2**size
		ps = Array.new(num,[])
		self.each_index do |i|
			a = 2**i
			b = 2**(i+1) - 1
			j = 0
			while j < num-1
				for j in j+a..j+b
					ps[j] += [self[i]]
				end
				j += 1
			end
		end
		ps
	end
end

print "Insert Array 1: "
arr1 = gets.chomp.split(' ')
print "Insert Array 2: "
arr2 = gets.chomp.split(' ')
puts "Array 1 is subset of Array 2" if arr1.subset?(arr2)
puts "Array 1 is superset of Array 2" if arr1.superset?(arr2)
print "Powerset of Array 1: "
p arr1.powerset
print "Powerset of Array 2: "
p arr2.powerset