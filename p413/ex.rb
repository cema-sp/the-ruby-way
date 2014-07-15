# encoding: utf-8

require 'gtk3'

class TextWindow < Gtk::Window
	def initialize
		super("Ruby/GTK3 - Текстовый редактор")
		signal_connect("destroy") {Gtk.main_quit}
		set_default_size(200,100)
		@text = Gtk::TextView.new
		@text.wrap_mode = :word
		
		@status = Gtk::Label.new
		
		@buffer = @text.buffer
		@buffer.signal_connect("changed") do
			@status.text = "Длина: " + @buffer.char_count.to_s
		end
		
		@buffer.create_tag('notice',
							'font' => "Arial Bold Italic 18",
							'foreground' => "red")
		
		scroller = Gtk::ScrolledWindow.new
		scroller.set_policy(:automatic, :never)
		scroller.add(@text)
		
		box = Gtk::Box.new(:vertical)
		box.add(scroller)
		box.add(@status)
		add(box)
		
		iter = @buffer.start_iter
		@buffer.insert(iter, "Это текстовый редактор")
		iter.offset = 3
		@buffer.insert(iter, " ВНЕЗАПНО", 'notice')
		
		show_all
	end
end

Gtk.init
TextWindow.new
Gtk.main