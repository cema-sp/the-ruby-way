# just an object
s1 = "cat"

# define singlet method
def s1.upcase
	"CaT"
end

puts "s1 = \t\t\t#{s1}"
puts "s1.upcase (dup) = \t#{s1.dup.upcase}"
puts "s1.upcase (clone) = \t#{s1.clone.upcase}"

# array with nesting
arr1 = [1, "2345", 6]

# duplicate
arr2 = arr1.dup
# copy by marshalling
arr3 = Marshal.load(Marshal.dump(arr1))

arr2[2] = 7
arr2[1][1] = "8"
arr3[2] = 9
arr3[1][1] = "0"

p arr1
p arr2
p arr3