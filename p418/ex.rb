# encoding: utf-8

require 'gtk3'

class MenuWindow < Gtk::Window
	def initialize
		super("Ruby/GTK3 - Меню")
		signal_connect("destroy") {Gtk.main_quit}
		
		file_exit_item = Gtk::MenuItem.new("_Выход")
		file_exit_item.signal_connect("activate") {Gtk.main_quit}
		file_exit_item.set_tooltip_text("Выход их программы")
		
		file_menu = Gtk::Menu.new
		file_menu.add(file_exit_item)
		
		file_menu_item = Gtk::MenuItem.new("_Файл")
		file_menu_item.submenu = file_menu
		
		menubar = Gtk::MenuBar.new
		menubar.append(file_menu_item)
		menubar.append(Gtk::MenuItem.new("_Тлен"))
		menubar.append(Gtk::MenuItem.new("_Безысходность"))
		
		#tooltip = Gtk::Tooltip.new
		#tooltip.set_tip(file_exit_item, "Выход их программы", "")
		
		box = Gtk::Box.new(:vertical)
		box.pack_start(menubar, expand: false, fill: false)
		box.add(Gtk::Label.new("Протестируйте меню"))
		
		add(box)
		
		set_default_size(300, 100)
		show_all
	end
end

Gtk.init
MenuWindow.new
Gtk.main