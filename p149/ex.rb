require 'open-uri'
#require 'iconv'

def get_web_page_as_utf8 url
	open url do |io| 
		source = io.read
		type, *parameters = io.content_type_parse
		#don't touch NON-HTML
		unless type =~ %r!^(?:text/html|application/xhtml+xml)$!
			return source
		end
		#checking headers from server
		if pair = parameters.assoc('charset')
			encoding = pair.last
		#searching for charset in HTML
		elsif source =~ /\]*?charset=([^\s'"]+)/i
			encoding = $1
		#if not found
		else
			encoding = 'ISO-8859-1'
		end
		#converter = Iconv.new('UTF-8//IGNORE',encoding)
		#return converter.iconv source
		source.encode('UTF-8',encoding,invalid: :replace, undef: :replace, replace: '')
	end
end

inp = ""
begin
	print "Insert URL (q - quit): "
	inp = gets.chop
		
	begin
		if inp != "q" then
			puts "ENCODED:"
			puts get_web_page_as_utf8(inp).gsub(/\>\<(?=[^\/])/,">\n<")
		end
	rescue
		puts "Something gone wrong!"
	end
	
end while inp != "q"