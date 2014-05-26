require 'iconv'

converter = Iconv.new('ISO-8859-15','UTF-8')
sword = "\u00e9p\u00e9e"
sword_iso = converter.iconv(sword)
sword_iso_new = sword.encode('ISO-8859-15','UTF-8')	#should use this method

puts "Sword (UTF):\t\t#{sword}"
puts "Sword (ISO):\t\t#{sword_iso}"
puts "Sword (ISO-new):\t#{sword_iso_new}"