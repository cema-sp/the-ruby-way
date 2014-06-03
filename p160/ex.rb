pi = 3.1415926535

puts "pi = #{pi}"
puts "pi.round = #{pi.round}"
puts "sprintf(\"%8.6f\",pi) = #{sprintf("%8.6f",pi)} (#{sprintf("%8.6f",pi).class})"
puts "eval(sprintf(\"%8.6f\",pi)) = #{eval(sprintf("%8.6f",pi))} (#{eval(sprintf("%8.6f",pi)).class})"
puts "sprintf(\"%8.6f\",pi).to_f = #{sprintf("%8.6f",pi).to_f} (#{sprintf("%8.6f",pi).to_f.class})"

class Float
	def roundf places
		temp = self.round.size
		sprintf("%#{temp}.#{places}f",self).to_f
	end
	def round2
		whole = self.floor
		fraction = self - whole
		if fraction == 0.5
			if whole % 2 == 0
				whole
			else
				whole+1
			end
		else
			self.round
		end
	end
end

puts "pi.roundf(3) = #{pi.roundf(3)} (#{pi.roundf(3).class})"

puts "round2:"
for i in 1..16
	puts "(#{33.2+i/10.0}).round2 = #{(33.2+i/10.0).round2}"
end