require 'win32ole'

print "Insert file name: "
docfile = gets.chomp
docfile = File.expand_path(File.dirname(__FILE__))+'/'+docfile

puts docfile

word = WIN32OLE.new "Word.Application"
word.visible = true

word.documents.open docfile
word.options.printBackground = false
word.activeDocument.printOut
word.quit