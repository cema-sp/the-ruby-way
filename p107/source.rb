s1 = "Hello, Cema!"
s2 = [s1].pack("m")
s3 = s2.unpack("m")

puts "Initial: "+s1
puts "Coded: "+s2
puts "Decoded: #{s3}"