require 'kirbybase'
require 'drb'

host = 'localhost'
port = 44444

db = KirbyBase.new(:server, nil, nil,
						"#{File.expand_path(File.dirname(__FILE__))}/kb")

DRb.start_service("druby://#{host}:#{port}",db)
DRb.thread.join