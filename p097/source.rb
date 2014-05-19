input = '"Doe, John", 35, 225, "5\'10\"", "555-0123"'
data = eval("["+ input + "]")
puts "Input: "+input
puts
puts "Result:"
data.each {|x| puts "Value = #{x}"}