# threads synchronization wih critical sections

x = 0
t1 = Thread.new do
	1.upto(1000) do
		x = x + 1
	end
end
t2 = Thread.new do
	1.upto(1000) do
		x = x + 1
	end
end

t1.join
t2.join

puts "With no sync: x = #{x}"

x = 0
t1 = Thread.new do
	1.upto(1000) do
		Thread.exclusive{x = x + 1}
	end
end
t2 = Thread.new do
	1.upto(1000) do
		Thread.exclusive{x = x + 1}
	end
end

t1.join
t2.join

puts "With critical section sync: x = #{x}"