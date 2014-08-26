require 'cgi'

def reverse_ramblings(ramblings)
	if ramblings[0] == nil then return " "; end
	chunks = ramblings.split(/\s+/)
	chunks.reverse.join(" ")
end

cgi = CGI.new("html5")
cgi.out do
	cgi.html do
		cgi.body do
			cgi.h1 { "Reverse Ramblings: " } +
			cgi.b { reverse_ramblings(cgi['rmb'])} +
			cgi.form("action"=>"/") do
				cgi.textarea("rmb") do
					cgi['rmb']
				end +
				cgi.submit
			end
		end
	end
end