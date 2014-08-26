require 'webrick'

path = File.expand_path(File.dirname(__FILE__))+"/html"
cgi_path = File.expand_path(File.dirname(__FILE__))+"/cgi"
server = WEBrick::HTTPServer.new(:Port=>8080, 
	:DocumentRoot=>path,
	:CGIInterpreter=>'C:\Software\Ruby200\bin\ruby.exe')
server.mount("/", 
	WEBrick::HTTPServlet::CGIHandler, cgi_path+"/ex.rb")

trap('INT') do
	server.shutdown
end

server.start