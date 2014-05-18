class String
	alias old_compare <=>
	def <=>(other)
		a = self.dup
		b = other.dup
		a.gsub!(/[\,\.\?\!\:\;]/,"")	#remove punctuation
		b.gsub!(/[\,\.\?\!\:\;]/,"")	#remove punctuation
		a.gsub!(/^(a |an |the )/i,"")	#remove articles from beginnings
		b.gsub!(/^(a |an |the )/i,"")	#remove articles from beginnings
		a.strip!
		b.strip!
		a.old_compare(b)
	end
end

title1 = "Calling All Cars"
title2 = "The Call of the Wild"

puts title1 < title2 ? "yes" : "no"