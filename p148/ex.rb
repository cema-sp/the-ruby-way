# encoding: utf-8
require 'iconv'

#eacute = [0x00e9].pack('U')
#sword = "#{eacute}p#{eacute}e"
sword = "épée"
broken_sword = "épée\xfe"

converter = Iconv.new('ISO-8859-15','UTF-8')
converter_ignore = Iconv.new('ISO-8859-15//IGNORE','UTF-8')

sword_iso = converter.iconv(sword)
sword_iso_new = sword.encode('ISO-8859-15','UTF-8')	#should use this method

puts "Sword (UTF):\t\t#{sword}"
puts "Sword (ISO):\t\t#{sword_iso}"
puts "Sword (ISO-new):\t#{sword_iso_new}"

begin
	broken_sword_iso_exc = converter.iconv(broken_sword) 
rescue 
	puts "ICONV Exception!!!"
end
begin
	broken_sword_iso_new_exc = broken_sword.encode('ISO-8859-15','UTF-8') 
rescue 
	puts "STRING Exception!!!"
end
puts "Broken Sword (ISO):\t#{broken_sword_iso_exc||'Exception'}"
puts "Broken Sword (ISO-new):\t#{broken_sword_iso_new_exc||'Exception'}"

broken_sword_iso = converter_ignore.iconv(broken_sword) 
broken_sword_iso_new = broken_sword.encode('ISO-8859-15','UTF-8', invalid: :replace, replace: '')

puts "Broken Sword (ISO):\t#{broken_sword_iso}"
puts "Broken Sword (ISO-new):\t#{broken_sword_iso_new}"

converter_just_repair = Iconv.new('UTF-8//IGNORE','UTF-8')
repaired_sword = converter_just_repair.iconv(broken_sword)
puts "Repaired sword:\t\t#{repaired_sword}"

converter_translit= Iconv.new('ASCII//TRANSLIT','UTF-8')
translited_sword = converter_translit.iconv(sword)
puts "Translited sword:\t#{translited_sword}"