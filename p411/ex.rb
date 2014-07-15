# encoding: utf-8

require 'gtk3'
# initialize gtk
Gtk.init

window = Gtk::Window.new("Дата")
# stop main loop on "close"
window.signal_connect("destroy") {Gtk.main_quit}
str = Time.now.strftime("Сегодня \n%B %d, %Y")
window.add(Gtk::Label.new(str))
window.set_default_size(200,100)
# display window
window.show_all

# start main loop
Gtk.main