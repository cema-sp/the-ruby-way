class String
	def levenshtein(other, ins=2, del=2, sub=1)
		return nil if self.nil?
		return nil if other.nil?
		
		dm=[]	#distances matrix
		
		dm[0] = (0..self.length).collect {|i| i*ins}
		fill = [0] * (self.length - 1)
		
		for i in 1..other.length
			dm[i] = [i* del, fill.flatten]
		end
		
		for i in 1..other.length
			for j in 1..self.length
				dm[i][j] = [
					dm[i-1][j-1] + 
						(self[j-1] == other[i-1] ? 0 : sub), 
							dm[i][j-1] + ins, 
								dm[i-1][j] + del
				].min
			end
		end
		dm[other.length][self.length]
	end
end

puts "ABCD".levenshtein("ABCDE")
puts "ABCD".levenshtein("DCBA")
puts "CEMA".levenshtein("CMEA")


