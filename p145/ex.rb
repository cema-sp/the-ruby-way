require 'unicode'

eacute = "\u00e9"
#eacute << 0303 << 0251		#U+00E9
sword = eacute.to_s + "p" + eacute.to_s + "e"
sword_kd = Unicode.normalize_KD(sword)
sword_kc = Unicode.normalize_KC(sword)

puts "Initial:\t"+sword
puts "KD:\t"+sword_kd
puts "KC:\t"+sword_kc

p sword_kc.scan(/./)
p sword_kd.scan(/./)
