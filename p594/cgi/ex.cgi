require 'cgi'

cgi = CGI.new('html5')

#print "Content-type: text/plain\n\n"
#print "Hello"

cgi.out do
	cgi.html do
		cgi.body do
			cgi.h1 do
				"Hello, " +
				cgi.b { cgi['name'] }
			end
		end
	end
end