require 'mathn'

list1 = []
Prime.each do |prime|
	list1 << prime
	break if list1.size == 20
end

for i in 0...20
	puts list1[i]
end

print "Insert number to check: "
#inp = gets.chop.to_i
puts gets.chop.to_i.prime? ? "Prime!" : "Not Prime!"