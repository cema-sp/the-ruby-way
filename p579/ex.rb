# SMTP mail sending example

require 'net/smtp'

msg = <<EOF
Subject: just a letter
Here is my letter
И оно на кириллице!
EOF

Net::SMTP.start(ARGV[0], 25, "[#{ARGV[3]}]", ARGV[1], ARGV[2]) do |smtp|
	smtp.sendmail(msg, ARGV[1], ARGV[4])
end