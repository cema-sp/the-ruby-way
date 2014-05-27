require 'open-uri'
require 'iconv'

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
		converter = Iconv.new('UTF-8//IGNORE',encoding)
		return converter.iconv(source)
	end
end

puts get_web_page_as_utf8 "http://ya.ru"