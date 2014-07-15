# encoding: utf-8

require 'gtk3'

class SampleWindow < Gtk::Window
	def initialize
		super("Ruby/GTK3 - Пример")
		signal_connect("destroy") {Gtk.main_quit}
		
		entry = Gtk::Entry.new
		
		button = Gtk::Button.new(label: "ALL CAPS!")
		button.signal_connect("clicked") do
			entry.text = entry.text.upcase
		end
		
		box = Gtk::Box.new(:horizontal, 10)
		box.add(Gtk::Label.new("Текст: "))
		box.add(entry)
		box.add(button)
		
		add(box)
		show_all
	end
end

Gtk.init
SampleWindow.new
Gtk.main