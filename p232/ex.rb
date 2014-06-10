# subset & superset of arrays
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
end

print "Insert Array 1: "
arr1 = gets.chomp.split(' ')
print "Insert Array 2: "
arr2 = gets.chomp.split(' ')
puts "Array 1 is subset of Array 2" if arr1.subset?(arr2)
puts "Array 1 is superset of Array 2" if arr1.superset?(arr2)