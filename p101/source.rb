require 'zlib'
include Zlib

long_string=("abcde"*71 + "defghi"*79 + "ghijkl"*113 )*371

s1 = Deflate.deflate(long_string, BEST_SPEED)
s2 = Deflate.deflate(long_string)
s3 = Deflate.deflate(long_string, BEST_COMPRESSION)

s4 = Inflate.inflate(s1)

puts "Initial length: #{long_string.size}"
puts "BEST_SPEED length: #{s1.length}"
puts "COMROMISE length: #{s2.length}"
puts "BEST_COMPRESSION length: #{s3.size}"

puts "Inflate s1 length: #{s4.length}"