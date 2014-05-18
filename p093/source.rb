class Helium
	def to_s
		"He (to_s)"
	end
	def to_str
		"Helium (to_str)"
	end
end

e = Helium.new
print "Element "
puts e
puts "Element "+e		#string behaviour (masquerading)
puts "Element #{e}"