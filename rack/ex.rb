# using rack from code

require 'rack'

# run with proc
app = Proc.new do |env|
	['200',
		{'Content-Type'=>'text/html'},
		['Hello, world!']]
end
#Rack::Handler::WEBrick.run(app)

# run with class
class MyClass
	def initialize(text)
		@text = text
	end
	def call(env)
		html = File.read(File.expand_path(File.dirname(__FILE__))+"/index.html")
		html_lines = html.split($/)
		html_lines << @text
		html_lines << env['QUERY_STRING']
		['200',
		{'Content-Type'=>'text/html'},
		html_lines]
	end
end

m = MyClass.new('Ruby working!')
Rack::Handler::WEBrick.run(m)