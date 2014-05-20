str = "I breath when I sleep"

r1 = /I (\w+) when I (\w+)/
s1 = str.sub r1,'I \2 when I \1'

r2 = /I (?<br>\w+) when I (?<sl>\w+)/
s2 = str.sub r2,'I \k<sl> when I \k<br>'

puts
puts "Initial:\t\t"+str
puts "Method 1 result:\t"+s1
puts "Method 2 result:\t"+s2