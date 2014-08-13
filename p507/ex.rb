require 'rexml/document'
include REXML

doc = Document.new(File.new(File.expand_path(
					File.dirname(__FILE__))+
					"/books.xml"))

p XPath.first(doc, "//book")
XPath.each(doc, "//title") {|e| puts e.text}
p XPath.match(doc, "//author").map {|x| x.text}