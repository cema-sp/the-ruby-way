require 'mathn'
#require 'benchmark'

#	puts "GCD of 345 and 125: #{345.gcd2 125}"	# not available any more
# my GCD algorithm
def gcd_my arr
	factors_a = Hash[arr[0].to_i.prime_division]
	factors_b = Hash[arr[1].to_i.prime_division]
	
	gcd = 1;
	
	factors_a.each do |num, cnt|
		if factors_b.has_key? num
			mul = [factors_b[num],cnt].min
			gcd *= num**mul
		end
	end
	
	gcd
end

# Euclid GCD algorithm
def gcd_euc arr
	a = arr[0].to_i
	b = arr[1].to_i
	

	loop do
		max = [a,b].max
		min = [a,b].min
		
		div = max % min
		
		if div == 0
			return min
			break
		else
			a>=b ? a = div : b = div
		end
	end
end

# Binary Euclid GCD Algorithm
def gcd_beuc arr
	a = arr[0].to_i
	b = arr[1].to_i
	
	k = 1;
	
	while (a!=0)&&(b!=0)
		while (a.even?)&&(b.even?)
			k <<= 1
			a >>= 1
			b >>= 1
		end
		a >>= 1 while a.even?
		b >>= 1 while b.even?
		a>=b ? a -= b : b -= a
	end
	
	b*k
end

# LCM Algorithm
def lcm arr
	factors_a = Hash[arr[0].to_i.prime_division]
	factors_b = Hash[arr[1].to_i.prime_division]
	
	lcm_h = factors_b.merge(factors_a) {|key, old, new| [old,new].max}
	
	Integer.from_prime_division(lcm_h.to_a)
end

inp = ""
begin
	print "Insert two numbers (' ' - separator, q - quit): "
	inp = gets.chop
	
	if inp!="q"
		b_time = Time.now
		1000.times {gcd_my inp.split(' ')}
		e_time = Time.now
		puts "GCD_MY: #{gcd_my inp.split(' ')} in #{(e_time-b_time)/1000.0}"
		
		b_time = Time.now
		1000.times {gcd_euc inp.split(' ')}
		e_time = Time.now
		puts "GCD_EUC: #{gcd_euc inp.split(' ')} in #{(e_time-b_time)/1000.0}"
		
		b_time = Time.now
		1000.times {gcd_beuc inp.split(' ')}
		e_time = Time.now
		puts "GCD_BEUC: #{gcd_beuc inp.split(' ')} in #{(e_time-b_time)/1000.0}"
		
		b_time = Time.now
		1000.times {lcm inp.split(' ')}
		e_time = Time.now
		puts "LCM: #{lcm inp.split(' ')} in #{(e_time-b_time)/1000.0}"
	end
	
end while inp!="q"