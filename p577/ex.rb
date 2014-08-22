# POP3 mail pulling example

require 'net/pop'
require 'base64'

def decode_email_mime(string)
	string = string.gsub(/\r/,"").gsub(/\n/," ")
	if (matched_string = string.match(%r[=\?([A-Za-z0-9\-]+)\?(B|Q)\?([!->@-~]+)\?=]i))
		encoded_part = (case matched_string[2]
			when 'Q','q'
				matched_string[3].unpack("M*")[0]
			when 'B','b'
				Base64.decode64(matched_string[3])
			end)
		decoded_part = encoded_part.encode("UTF-8",matched_string[1].upcase)
		matched_string.pre_match+decoded_part+decode_email_mime(matched_string.post_match)
	else
		if string.encoding.to_s == "ASCII-8BIT"
			string.force_encoding("IBM866").encode("UTF-8")
		else
			string
		end
	end
end

pop = Net::POP3.new(ARGV[0])
pop.start(ARGV[1],ARGV[2])
pop.mails.each do |msg|
	#puts msg.header.split($/)
	subject = msg.header.split($/).grep(/^Subject:\s/)[0]
	puts decode_email_mime(subject)
end