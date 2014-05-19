def columnate(str, max=20)
	line = 0
	out=[""]

	input = str.gsub(/\s/," ")
	words = input.split(" ")

	while input!=""
		word = words.shift
		break if not word
		
		if out[line].length + word.length > max
			out[line].squeeze!(" ")
			out[line].chop!
			line += 1
			out[line] = ""
		end
		out[line] << word + " "
	end
	out
end

def justify(inp_str, max)
	str = inp_str.clone
	search = " "
	ind = 0
	#puts str.length
	while (str.length<max)&&(not str.index(search).nil?)
		ind = str.index(search,ind)
		if (not ind.nil?)&&(ind+search.length+1<str.length) 
			str[ind] = "  "
			#puts str
			ind = ind+search.length+1
		else
			ind = 0
			search+=" "
		end
	end
	str
end

str = <<EOF
When in the Course of human events it becomes necessary
for one people to dissolve the political bands which have
connected them with another, and to assume among the powers
of the earth the separate and equal station to which the Laws
of Nature and of Nature's God entitle them, a decent respect
for the opinions of mankind requires that they should declare
the causes which impel them to the separation.
EOF

print "Enter column size: "
max = gets.chop.to_i
puts
columnate(str, max).each{|line| puts justify(line,max)}

#arr = columnate(str, max)
#for i in 0..arr.length
#	print justify(arr[i], 20)
#	gets
#end