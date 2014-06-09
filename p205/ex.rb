def nth_wday(n, wday, month, year)
	if (!n.between? 1,5) or
		(!wday.between? 0,6) or
		(!month.between? 1,12)
			raise ArgumentError
	end
	t = Time.local(year,month,1)
	first = t.wday
	if first == wday
		fwd = 1
	elsif first<wday
		fwd = 1 + (wday - first)
	elsif first>wday
		fwd = 1 + 7 - (first - wday)
	end
	target = fwd + (n-1)*7
	
	begin
		t2 = Time.local(year, month, target)
	rescue ArgumentError
		return nil
	end
	
	t2.mday == target ? t2 : nil
end

print "Insert ' '-delimited year, month, wday, n: "
year, month, wday, n = gets.chomp.split(' ').map(&:to_i)
puts "Result: #{nth_wday(n, wday, month, year)}"