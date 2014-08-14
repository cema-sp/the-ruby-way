require 'rexml/document'
include REXML

input = File.new(File.expand_path(File.dirname(__FILE__))+
					"/books.xml")
doc = Document.new(input)
puts doc.root.attributes["shelf"]

doc.elements.each("library/section") do |e|
	puts e.attributes["name"]
end

doc.elements.each("*/section/book") do |e|
	puts e.attributes["isbn"]
end

sec2 = doc.root.elements[2]
author = sec2.elements[1].elements["author"].text