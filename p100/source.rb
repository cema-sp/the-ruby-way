class String
	def rot13
		self.tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")
	end
end

joke = "Y2K bug"
puts joke.rot13

puts "Hello World".rot13.rot13

coded = "hfCghHIE5LAM."

puts "Tell and press \"Enter\", friend!"
print "Password: "
password = gets.chop

if password.crypt("hf") == coded
	puts "Welcome, Master!"
else
	puts "Who are you!?"
end