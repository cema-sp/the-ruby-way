# encoding: UTF-8

require 'Qt'

class TimerClock < Qt::Widget
	def initialize(parent = nil)
		super(parent)
		
		@timer = Qt::Timer.new(self)
		# update() slot is built-in
		connect(@timer, SIGNAL('timeout()'),
				self, SLOT('update()'))
		@timer.start(25)
		
		setWindowTitle('Секундомер')
		resize(200,200)
	end
	
	def paintEvent(e)
		fast_hand = Qt::Polygon.new([Qt::Point.new(7,8),
									Qt::Point.new(-7,8),
									Qt::Point.new(0,-80)])
		second_hand = Qt::Polygon.new([Qt::Point.new(7,8),
										Qt::Point.new(-7,8),
										Qt::Point.new(0,-65)])
		fast_color = Qt::Color.new(0,150,150,150)
		second_color = Qt::Color.new(100,0,100)
		
		side = [width, height].min
		time = Qt::Time.currentTime
		
		painter = Qt::Painter.new(self)
		painter.renderHint = Qt::Painter::Antialiasing
		painter.translate(width()/2,height()/2)
		painter.scale(side/200.0,side/200.0)
		
		painter.pen = Qt::NoPen
		painter.brush = Qt::Brush.new(second_color)
		
		painter.save
		painter.rotate(6.0 * time.second)
		painter.drawConvexPolygon(second_hand)
		painter.restore
		
		painter.pen = second_color
		(0..12).each do |i|
			painter.drawLine(88,0,96,0)
			painter.rotate(30.0)
		end
		
		painter.pen = Qt::NoPen
		painter.brush = Qt::Brush.new(fast_color)
		
		painter.save
		painter.rotate(36.0 * (time.msec / 100.0))
		painter.drawConvexPolygon(fast_hand)
		painter.restore
		
		painter.pen = fast_color
		(0..60).each do |j|
			if (j%5) != 0
				painter.drawLine(92,0,96,0)
			end
			painter.rotate(6.0)
		end
		
		painter.end
	end
end

class TissotSecond < Qt::Widget
	def initialize(parent = nil)
		super(parent)
		
		@timer = Qt::Timer.new(self)
		# update() slot is built-in
		connect(@timer, SIGNAL('timeout()'),
				self, SLOT('update()'))
		@timer.start(1000)
		
		setWindowTitle('Секунды')
		resize(200,200)
	end
	
	def paintEvent(e)
		second_hand = Qt::Polygon.new([Qt::Point.new(-3,0),
										Qt::Point.new(3,0),
										Qt::Point.new(3,-88),
										Qt::Point.new(0,-96),
										Qt::Point.new(-3,-88)])

		second_color = Qt::Color.new(100,0,100)
		
		side = [width, height].min
		time = Qt::Time.currentTime
		
		painter = Qt::Painter.new(self)
		painter.renderHint = Qt::Painter::Antialiasing
		painter.translate(width()/2,height()/2)
		painter.scale(side/200.0,side/200.0)
		
		painter.pen = Qt::NoPen
		painter.brush = Qt::Brush.new(second_color)
		
		painter.save
		painter.rotate(6.0 * time.second)
		painter.drawConvexPolygon(second_hand)
		painter.restore
		
		painter.drawEllipse(Qt::Point.new(0,0), 10, 10)
		
		painter.pen = second_color

		(0..60).each do |j|
			if (j%5) != 0
				painter.drawLine(92,0,96,0)
			else
				painter.drawLine(88,0,96,0)
			end
			painter.rotate(6.0)
		end
		
		painter.end
	end
end

app = Qt::Application.new(ARGV)
wid = TimerClock.new
wid.show
app.exec