require 'prawn'

path = File.expand_path(File.dirname(__FILE__))

Prawn::Document.generate(path+"/my_doc.pdf") do
	text "Hello There"
	stroke_axis
	stroke_circle [0,0], 10

	bounding_box([100,300], 
		:width => 300, :height => 200) do
		stroke_bounds
		stroke_circle [0,0], 10	
	end
end