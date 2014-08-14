require 'pdf/writer'

path = File.expand_path(File.dirname(__FILE__))

def quadrant(pdf,quad)
	raise unless block_given?
	mx = pdf.absolute_x_middle
	my = pdf.absolute_y_middle
	pdf.save_state

	case quad
	when :ul
		pdf.translate_axis 0, my
	when :ur
		pdf.translate_axis mx, my
	when :ll
		nil
	when :lr
		pdf.translate_axis mx, 0
	end

	pdf.scale_axis(0.5,0.5)
	pdf.y = pdf.page_height
	yield
	pdf.restore_state
end

pdf = PDF::Writer.new
pdf.select_font("Times-Roman",
				:encoding => "WinAnsiEncoding",
				:differences => {0x01 => "lozenge"})
mx = pdf.absolute_x_middle
my = pdf.absolute_y_middle

pdf.line(0,my,pdf.page_width,my).stroke
pdf.line(mx,0,mx,pdf.page_height).stroke

# Upper Left

quadrant(pdf, :ul) do
	x = pdf.absolute_right_margin
	rl = 25

	40.step(1,-3) do |xw|
		tone = 1.0 - (xw / 40.0) * 0.2
		pdf.stroke_style(PDF::Writer::StrokeStyle.new(xw))
		pdf.stroke_color(Color::RGB.from_fraction(1, tone, tone))
		pdf.line(x, pdf.bottom_margin, x, pdf.absolute_top_margin).stroke
		x -= xw+2
	end

	40.step(1,-3) do |xw|
		tone = 1.0 - (xw / 40.0) * 0.2
		pdf.stroke_style(PDF::Writer::StrokeStyle.new(xw))
		pdf.stroke_color(Color::RGB.from_fraction(1, tone, tone))
		pdf.circle_at(pdf.left_margin+10,pdf.margin_height-15, rl).stroke
		rl += xw
	end

	pdf.stroke_color(Color::RGB::Black)

	x = pdf.absolute_left_margin
	y = pdf.absolute_bottom_margin
	w = pdf.margin_width
	h = pdf.margin_height-15

	pdf.rectangle(x,y,w,h).stroke

	text = "Cema"

	y = pdf.absolute_top_margin
	50.step(5, -5) do |size|
		height = pdf.font_height(size)
		y -= height
		pdf.add_text(pdf.left_margin+10, y, text, size)
	end

	(0..360).step(20) do |angle|
		pdf.fill_color(Color::RGB.from_fraction(rand, rand, rand))
		pdf.add_text(300+Math.cos(PDF::Math.deg2rad(angle))*40,
					300+Math.sin(PDF::Math.deg2rad(angle))*40,
					text, 20, angle)
	end
end

pdf.fill_color(Color::RGB::Black)

# Upper Right

quadrant(pdf, :ur) do

	# NO MORE SUPPORTED
	#pdf.image(path+"/image.jpg",
	#		:height => pdf.margin_height,
	#		:resize => :width)
	#pdf.text("Nature Morte au Hareng",
	#		:justification => :center,
	#		:font_size => 36)
	#pdf.text("\001Guido Mocafico\001",
	#		:justification => :center,
	#		:font_size => 24)
	pdf.move_pointer(24)
	info = <<-'EOS'.split($/).join(" ").squeeze(" ")
		The Guido Mocafico: Nature Morte exhibition–a collaboration between
	Bernheimer Fine Art Photography and Hamiltons Gallery, London–
	focuses on photographs inspired by the aesthetics of Old Masters. Born
	in Italy in 1962, the photographer concentrates in this exhibition primarily
	on three genres of still life: banquet, floral and vanitas still lifes, or as
	Mocafico calls his groups of works, natures mortes de table, bouquets and
	vanités.The bouquet and vanité works are new and are being shown to the
	public here for the first time. At first glance, the photographs seem hardly
	distinguishable from the compositions of the Old Masters that supplement
	the exhibition, because in his remarkable works, which are planned down
	to the last detail, Mocafico replicates typical still lifes of the 17th and
	18th centuries (cf. cat. I–VIII).
	EOS
	pdf.text(info, :justification => :full,
			:font_size => 24, :left => 100, :right => 100)
end

pdf.fill_color(Color::RGB::Black)

# Lower Left

quadrant(pdf, :ll) do
	require 'color/palette/monocontrast'

	class IndividualI
		attr_accessor :size

		def initialize(size = 100)
			@size = size
		end
		def half_i(pdf)
			pdf.move_to(0,82)
			pdf.move_to(0,78)
			pdf.move_to(9,78)
			pdf.move_to(9,28)
			pdf.move_to(0,28)
			pdf.move_to(0,23)
			pdf.move_to(18,23)
			pdf.move_to(18,82)
			pdf.fill
		end
		private :half_i

		def draw(pdf, x, y)
			pdf.save_state
			pdf.translate_axis(x,y)
			pdf.scale_axis(1*(@size/100.0), -1 * (@size/100.0))

			pdf.circle_at(20,10,7.5)
			pdf.fill

			half_i(pdf)

			pdf.translate_axis(40,0)
			pdf.scale_axis(-1,1)

			half_i(pdf)
			pdf.restore_state
		end
	end

	ii = IndividualI.new(24)
	x = pdf.absolute_left_margin
	y = pdf.absolute_top_margin
	bg = Color::RGB.from_fraction(rand, rand, rand)
	fg = Color::RGB.from_fraction(rand, rand, rand)
	pal = Color::Palette::MonoContrast.new(bg,fg)

	sz = 24

	(-5..5).each do |col|
		pdf.fill_color pal.background[col]
		ii.draw(pdf, x, y)
		ii.size += sz
		x += sz / 2.0
		y -= sz / 2.0
		pdf.fill_color pal.foreground[col]
		ii.draw(pdf, x, y)
		x += sz / 2.0
		y -= sz / 2.0
		ii.size += sz
	end
end

pdf.fill_color(Color::RGB::Black)

# Lower Right

quadrant(pdf, :lr) do
	pdf.text("Farewell to Baseball Address\n\n", :font_size => 36, 
			:justification => :center)
	y0 = pdf.y + 18

	text = <<-'EOF'.split($/).join(" ").squeeze(" ")
Fans, for the past two weeks you have been reading about a bad break I got. Yet today I consider myself the luckiest man on the face of the earth. I have been in ballparks for seventeen years and have never received anything but kindness and encouragement from you fans.
Look at these grand men. Which of you wouldn’t consider it the highlight of his career to associate with them for even one day?
Sure, I’m lucky. Who wouldn’t consider it an honor to have known Jacob Ruppert – also the builder of baseball’s greatest empire, Ed Barrow – to have spent the next nine years with that wonderful little fellow Miller Huggins – then to have spent the next nine years with that outstanding leader, that smart student of psychology – the best manager in baseball today, Joe McCarthy!
Sure, I’m lucky. When the New York Giants, a team you would give your right arm to beat, and vice versa, sends you a gift, that’s something! When everybody down to the groundskeepers and those boys in white coats remember you with trophies, that’s something.
When you have a wonderful mother-in-law who takes sides with you in squabbles against her own daughter, that’s something. When you have a father and mother who work all their lives so that you can have an education and build your body, it’s a blessing! When you have a wife who has been a tower of strength and shown more courage than you dreamed existed, that’s the finest I know.
So I close in saying that I might have had a tough break – but I have an awful lot to live for!
	EOF

	pdf.text(text, :justification => :full, 
			:font_size => 14, :left => 50, :right => 50)
	pdf.move_pointer(36)
	pdf.text("Lou Gehrig", :justification => :right, :right => 100)
	pdf.text("Yankee Stadium, July 4, 1939", :justification => :right, :right => 100)
	pdf.rounded_rectangle(pdf.left_margin+25, y0, 
		pdf.margin_width-50, y0 - pdf.y + 18, 10).stroke
end

pdf.save_as(path+"/my_new.pdf")