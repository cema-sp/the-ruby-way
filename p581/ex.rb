# IMAP mail pulling example

require 'net/imap'

module Net
	class IMAP
		class ResponseParser
			def response_cond
				token = match(T_ATOM)
				name = token.value.upcase
				return UntaggedResponse.new(name, resp_text, @str)
		    end
		end
	end
end

imap = Net::IMAP.new(ARGV[0])
begin
	imap.login(ARGV[1],ARGV[2])

	imap.examine("INBOX")
	total = imap.responses["EXISTS"].last
	recent = imap.responses["RECENT"].last
	#unseen = imap.responses["UNSEEN"].last
	imap.close

	puts "Recent: #{recent}/#{total}"
	#puts "Unseen: #{unseen}/#{total}"
rescue Net::IMAP::NoResponseError
	abort "Failed to authenticate use #{ARGV[1]}"
end

imap.logout