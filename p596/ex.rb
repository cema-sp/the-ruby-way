require 'cgi'

lastacc = CGI::Cookie.new("my_cookie", 
							"last_access=#{Time.now.to_s}")

cgi = CGI.new('html5')

if cgi.cookies.size < 1
	cgi.out("cookie"=>lastacc) do
		"You are here first time"
	end
else
	cgi.out("cookie"=>lastacc) do
		cgi.html do
			"You were here at: "+
			"#{cgi.cookies['my_cookie'].join.split('=')[1]}"
		end
	end
end