require "unicode"

def transform_de str
	decomposed = Unicode.normalize_KD(str).downcase
	decomposed.gsub!('ß', 'ss')
	decomposed.gsub([0x0308].pack('U'), 'e')
end

def map_table list
	table = {}
	list.each_with_index do |item, i|
		item.split(',').each do |subitem| 
			table[Unicode.normalize_KC subitem] = (?a.ord + i).chr
		end
	end
	table
end

def collate array
	transformations = array.inject({}) do |hash, item|
		hash[item] = yield item
		hash
	end
	array.sort_by {|x| transformations[x]}
end

ES_SORT = map_table(%w(a,A,á,Á b,B c,C d,D e,E,é,É f,F g,G h,H i,I,í,Í 
						j,J k,K l,L m,M n,N ñ,Ñ o,O,ó,Ó p,P q,Q r,R s,S t,T u,U,ú,Ú 
						v,V w,W x,X y,Y z,Z))

#method returns bullshit-looking words
def transform_es str
	array = Unicode.normalize_KC(str).scan(/./u)
	array.map {|c| ES_SORT[c] || c}.join
end
		
array = ["Straße", "öffnen"]
puts "Initial array (DE): "
p array
puts "Transformed array (DE): "
p array.map {|x| transform_de x}

puts "ES_SORT: "
p ES_SORT

array = %w/éste estoy año apogeo amor/
puts "Initial array (ES): "
p array
puts "Transformed array (ES): "
p array.map {|x| transform_es x}
puts "Collated array (ES): "
p collate(array) {|x| transform_es x}
p array.sort_by {|x| transform_es x}	#same as previous but simpler