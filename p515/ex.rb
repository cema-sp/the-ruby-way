require 'RMagick'

def do_flip(img)
	img.flip
end
def do_rotate(img)
	img.rotate(45)
end
def do_implode(img)
	img.implode(0.65)
end
def do_resize(img)
	img.resize(240,120)
end
def do_text(img)
	text = Magick::Draw.new
	text.annotate(img,0,0,0,100,"HELLO") do
		self.gravity = Magick::SouthGravity
		self.pointsize = 72
		self.stroke = 'black'
		self.fill = '#FAFAFA'
		self.font_weight = Magick::BoldWeight
		self.font_stretch = Magick::UltraCondensedStretch
	end
	img
end
def do_emboss(img)
	img.emboss
end
def do_spread(img)
	img.spread(10)
end
def do_motion(img)
	img.motion_blur(0,30,170)
end
def do_oil(img)
	img.oil_paint(10)
end
def do_charcoal(img)
	img.charcoal
end
def do_vignette(img)
	img.vignette
end
def do_affine(img)
	spin_xform = Magick::AffineMatrix.new(1, Math::PI/6, Math::PI/6, 1, 0, 0)
	img.affine_transform(spin_xform)
end

def example(old_file, meth, new_file)
	img = Magick::ImageList.new(old_file)
	new_img = send(meth,img)
	new_img.write(new_file)
end

#-------------------------------------------

path = File.expand_path(File.dirname(__FILE__))
initial_file = path+"/big.png"

self.private_methods.select{|x| x =~ /^do\_/}.each do |meth|
	example(initial_file, meth, path+"/"+meth.to_s+".jpg")
end