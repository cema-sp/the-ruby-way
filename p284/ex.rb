# matrix(array of arrays) serialization and reading

print "Insert dimension: "
dim = gets.chomp.to_i
mtx = []
puts "Insert lines of numbers (' '-separated):"
# creation
dim.times do |i|
	print "line #{i+1}: "
	mtx[i] = gets.chomp.split(' ')
end
p mtx
# serialization
File.open('p284/ser.txt','w+') do |file|
	mtx.each {|line| file.puts line.join(';')}
end
puts "Access file (q to quit):"
loop do
	print "Insert indexes: "
	inp = gets.chomp
	break if inp=='q'
	i,j = inp.split(' ').map(&:to_i)
	# access file
	File.open('p284/ser.txt','r') do |file|
		file.seek(i*(2*dim+1)+2*j)
		puts "Result: #{file.getc}"
	end
end