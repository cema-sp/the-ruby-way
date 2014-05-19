def oniguruma?
	puts "RUBY V. >= 1.9.0" if RUBY_VERSION>= "1.9.0"
	if defined?(Regexp::ENGINE)
		if Regexp::ENGINE.include?('Oniguruma')
			puts "Oniguruma present"
		else
			puts  "Old library"
		end
	end
	
	eval("/(?<!a)b/")	#new syntax
	puts "Syntax working"
	rescue SyntaxError
		puts "Syntax Error"
end

oniguruma?