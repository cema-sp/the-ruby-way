# encoding: UTF-8

puts "LANG='#{ENV["LANG"]}'"
puts "Encoding.default_external='#{Encoding.default_external}'"
puts "Encoding.default_internal='#{Encoding.default_internal}'"
#puts "Encoding.name_list='#{Encoding.name_list}'"

eacute = "\u00e9"
p eacute
eacute2 = "é"
#eacute << 0303 << 0251		#U+00E9
sword = eacute.to_s + "p" + eacute2 + "e"

p "p e acute: "+eacute
p "p sword: "+sword
puts "puts sword: "+sword
puts "sword length: #{sword.length}"
puts "sword Capitalize: #{sword.capitalize}"
puts "sword UPCASE: #{sword.upcase}"
puts "sword unpack: #{sword.unpack('U*')}"
