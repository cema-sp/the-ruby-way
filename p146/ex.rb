require 'unicode'

eacute = [0x00e9].pack('U')
acute = [0x0301].pack('U')
array = %W[epicurian #{eacute}p#{eacute}e e#{acute}lan]

def transform str
	Unicode.normalize_KD(str).unpack('U*').select{ |cp|
		cp < 0x0300 || cp > 0x036f
	}.pack('U*')
end

def collate array
	transformations = array.inject({}) do |hash, item|
		hash[item] = yield item
		hash
	end
	array.sort_by {|x| transformations[x]}
end

collated_array = collate(array) {|a| transform a}

print 'Initial array: '
p array
puts
puts 'Array#sort: '
puts array.sort
puts
puts 'Unsigned char codes: '
array.map do |item|
	puts "#{item}: #{item.unpack('C*')[0..-1].join(', ')}"
end
puts
puts 'Transormation: '
array.map{ |item|
	puts "#{item} -> #{transform item}"
}
puts
puts 'Transformed sort: '
puts collated_array