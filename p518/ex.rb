require 'RMagick'

img = Magick::ImageList.new
img.new_image(500,500)

purplish = '#FF55FF'
yuck = '#5FFF62'
bleah = '#3333FF'

line = Magick::Draw.new
50.step(450,50) do |n|
	line.line(n,50,n,450)
	line.draw(img)
	line.line(50,n,450,n)
	line.draw(img)
end

circle = Magick::Draw.new
circle.fill(purplish)
circle.stroke('black').stroke_width(1)
circle.circle(250,200,250,310)
circle.draw(img)

rectangle = Magick::Draw.new
rectangle.fill(yuck)
rectangle.stroke('black').stroke_width(1)
rectangle.rectangle(340,380,237,110)
rectangle.draw(img)

triangle = Magick::Draw.new
triangle.fill(bleah)
triangle.stroke('black').stroke_width(1)
triangle.polygon(90,320,160,370,390,120)
triangle.draw(img)

# img = img.quantize(256, Magick::GRAYColorspace)

img.write(File.expand_path(File.dirname(__FILE__))+"/new.jpg")