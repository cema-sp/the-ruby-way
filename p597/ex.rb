require 'cgi'
require 'cgi/session'

cgi = CGI.new("html5")

sess = CGI::Session.new(cgi, "session_key" => "a_test", 
						"prefix" => "rubysess.")

lastaccess = sess["lastaccess"].to_s
sess["lastaccess"] = Time.now
if cgi['bgcolor'][0] =~ /[a-z]/
	sess['bgcolor'] = cgi['bgcolor']
end

cgi.out do
	cgi.html do
		cgi.body("bgcolor" => sess['bgcolor']) do
			"This page's background\n"+
			"changes according to 'bgcolor'\n"+
			"GET parameter.\n"+
			"Last access time: #{lastaccess}"
		end
	end
end