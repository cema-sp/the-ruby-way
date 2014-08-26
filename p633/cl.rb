# drb client example
require 'drb'

class Warner
	include DRbUndumped

	def initialize(ticker, limit)
		@limit = limit
		ticker.add_observer(self)
	end
end

class WarnLow < Warner
	def update(time, price)
		if price < @limit
			puts "--- #{time.to_s}: Price is lower #@limit: #{price}"
		end
	end
end

class WarnHigh < Warner
	def update(time, price)
		if price > @limit
			puts "+++ #{time.to_s}: Price is higher #@limit: #{price}"
		end
	end
end

#-----------------------------------------------------------

DRb.start_service
ticker = DRbObject.new(nil, "druby://localhost:9001")

WarnLow.new(ticker, 90)
WarnHigh.new(ticker, 110)

DRb.thread.join