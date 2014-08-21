# NTP server request with telnet protocol
require 'net/telnet'

timeserver = ARGV[0]||'pool.ntp.org'

local = Time.now.strftime("%H:%M:%S")
puts "Connection to #{timeserver}..."
tn = Net::Telnet.new("Host"=> timeserver,
					"Port"=> "time",
					"Timeout"=>60,
					"Telnetmode"=>false)

msg = tn.recv(4).unpack('N')[0]
remote = Time.at(msg-2208988800).strftime("%H:%M:%S")

puts "Local: \t#{local}"
puts "Remote: \t#{remote}"