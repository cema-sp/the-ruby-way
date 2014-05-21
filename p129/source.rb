#IP address matching

#pattern creation with string
num = "(\\d|[01]?\\d\\d|2[0-4]\\d|25[0-5])"
pat = "^(#{num}\.){3}#{num}$"
ip_pat = Regexp.new(pat)

#pattern creation with regexp syntax
num_r = /\d|[01]?\d\d|2[0-4]\d|25[0-5]/
pat_r = /^(#{num}\.){3}#{num}$/
ip_pat_r = pat_r
ip_pat_r_mix = /#{ip_pat_r}/mix

print "Show patterns? [y/n] : "
if gets.chop =~ /y/
	puts "num: "+num
	puts "pat: "+pat
	puts "ip_pat: "+ip_pat.to_s

	puts "num_r: "+num_r.to_s
	puts "pat_r: "+pat_r.to_s
	puts "ip_pat_r: "+ip_pat_r.to_s
	puts "ip_pat_r_mix: "+ip_pat_r_mix.to_s
end
ip = ""
begin
	print "Enter IP for check (q - quit): "
	ip = gets.chop
	if ip != "q" 
		print ip =~ ip_pat ? "Correct IP\t" : "Wrong IP\t"
		puts ip =~ ip_pat_r ? "Correct IP\t" : "Wrong IP\t"
	end
end while ip != "q" 