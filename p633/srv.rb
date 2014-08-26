# drb server example
require 'drb'
require_relative 'obs'

# random price generator
class MockPrice
	MIN = 75
	RANGE = 50

	def initialize(symbol)
		@price = RANGE / 2
	end

	def price
		@price += (rand() - 0.5)*RANGE
		if @price<0
			@price = -@price
		elsif @price >= RANGE
			@price = 2*RANGE - @price
		end
		MIN+@price
	end
end

# periodical price checker
class Ticker
	include DRbObservable

	def initialize(price_feed)
		@feed = price_feed
		Thread.new {run}
	end

	def run
		last_price = nil
		loop do
			price = @feed.price
			puts "Current rate: #{price}"
			if price != last_price
				last_price = price
				notify_observers(Time.now, price)
			end
			sleep 1
		end
	end
end

#------------------------------------------------------------

ticker = Ticker.new(MockPrice.new("RTS"))

DRb.start_service('druby://localhost:9001', ticker)
DRb.thread.join