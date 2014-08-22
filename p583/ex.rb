# SMTP MIME mail with attachment sending example

require 'net/smtp'

PATH = File.expand_path(File.dirname(__FILE__))+"/"

def text_plus_attachment(subject, body, filename)
	marker = "MIME_boundary"
	middle = "--#{marker}\n"
	ending = "--#{middle}--\n"
	content = "Content-Type: Multipart/Related; " +
				"boundary=#{marker}; " +
				"typew=text/plain"
	head_1 = <<-EOF
	MIME-Version: 1.0
	#{content}
	Subject: #{subject}
	EOF
	binary = File.read(PATH+filename)
	encoded = [binary].pack("m")	# base64 encode

	head_2 = <<-EOF
	Content-Description: "#{filename}"
	Content-Type: image/gif; name="#{filename}"
	Content-Transfer-Encoding: Base64
	Content-Disposition: attachment; filename="#{filename}"
	EOF

	head_1+middle+body+middle+head_2+encoded+ending

end

#----------------------------------------------------------------

body = <<-EOF
Это мое сообщение с аттачем.


		--Cema
EOF

mail_text = text_plus_attachment("Привет!", body, "smtp.gif")

Net::SMTP.start(ARGV[0], 25, "[#{ARGV[3]}]", ARGV[1], ARGV[2], :plain) do |smtp|
	smtp.sendmail(mail_text, ARGV[1], ARGV[4])
end