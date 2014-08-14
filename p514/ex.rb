require 'RMagick'

path = File.expand_path(File.dirname(__FILE__))
img = Magick::ImageList.new(path+"/big.png")

pics = []

# the fastest method
pics << img.thumbnail(0.2)
pics << img.thumbnail(30,20)

# mild speed
pics << img.resize(0.4)
pics << img.resize(400,150)
# with distortion
pics << img.resize(250,100,Magick::LanczosFilter,0.9)

# mild speed
pics << img.sample(0.33)
pics << img.sample(400,150)

# the slowest method
pics << img.scale(0.6)
pics << img.scale(450,170)

pics.each_with_index do |pic,i|
	pic.write(path+"/pic#{i}.png")
end
