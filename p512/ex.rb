require 'RMagick'

def show_info(fname)
	img = Magick::Image::read(fname).first
	fmt = img.format
	w,h = img.columns, img.rows
	dep = img.depth
	nc = img.number_colors
	nb = img.filesize
	xr = img.x_resolution
	yr = img.y_resolution
	res = Magick::PixelsPerInchResolution ? "inch" : "cm"
	puts <<-EOF
	File:		#{fname}
	Format:		#{fmt}
	Dimensions:	#{w}x#{h} pixels
	Colors:		#{nc}
	Size:		#{nb} bytes
	Resolution:	#{xr}/#{yr} pixels per #{res}
	EOF

	puts
end

show_info(File.expand_path(File.dirname(__FILE__))+
		"/small.jpg")
show_info(File.expand_path(File.dirname(__FILE__))+
		"/big.png")