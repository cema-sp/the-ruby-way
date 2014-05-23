#date parsing
mo = /0?[1-9]|1[12]/
dd = /0?[1-9]|[12]\d|3[01]/
yyyy = /[12]\d\d\d/
hh = /[01]?\d|2[0-3]/
mi = /[0-5]\d/
ss = /[0-5]\d/

#format: 01.12.2014 15:00:00
format_1 = /(#{dd}\.#{mo}\.#{yyyy})\s(#{hh}\:#{mi}\:#{ss})/

begin
	print "Enter date (q - quit): "
	input_str = gets.chop
	puts format_1 =~ input_str ? "Matches pattern" : "Doesn't match!"
end while input_str!='q'