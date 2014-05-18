class String
	def rot13
		self.tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")
	end
end

joke = "Y2K bug"
puts joke.rot13

puts "Hello World".rot13.rot13