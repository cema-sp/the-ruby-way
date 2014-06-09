require 'date'

print "Insert ' '-delimeted year, month, day: "
date = gets.chomp.split(' ').map(&:to_i)

t = Time.local(*date)
d = Date.new(*date)

puts "From Sunday: #{t.strftime("%U")}"
puts "From Monday: #{t.strftime("%W")}"
puts "From ISO: #{d.cweek}"
puts "JLeap: #{Date.julian_leap? date[0]}"
puts "GLeap: #{Date.leap? date[0]}"