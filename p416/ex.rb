# encoding: utf-8

require 'gtk3'

class TicketWindow < Gtk::Window
	def initialize
		super("АвиаБилеты")
		signal_connect("destroy") {Gtk.main_quit}
		
		dest_model = Gtk::ListStore.new(String, String)
		dest_view = Gtk::TreeView.new(dest_model)
		dest_column = Gtk::TreeViewColumn.new("Назначение",
						Gtk::CellRendererText.new,
						text: 0)
		dest_view.append_column(dest_column)
		country_column = Gtk::TreeViewColumn.new("Страна",
						Gtk::CellRendererText.new,
						text: 1)
		dest_view.append_column(country_column)
		dest_view.selection.set_mode(:single)
		
		[["Москва", "Россия"], ["Краснодар", "Россия"],
			["Минск", "Белоруссия"]].each do |destination, country|
				iter = dest_model.append
				iter[0] = destination
				iter[1] = country
		end
		dest_view.selection.signal_connect("changed") do
			@city = dest_view.selection.selected[0]
		end
		
		@round_trip = Gtk::CheckButton.new("Обратный билет")
		
		purchase = Gtk::Button.new(label: "Купить")
		purchase.signal_connect("clicked") {cmd_purchase}
		
		@result = Gtk::Label.new
		
		@coach = Gtk::RadioButton.new("Эконом класс")
		@business = Gtk::RadioButton.new(@coach, "Бизнес класс")
		@first = Gtk::RadioButton.new(@coach, "Первый класс")
		
		flight_box = Gtk::Box.new(:vertical)
		flight_box.add(dest_view).add(@round_trip)
		
		seat_box = Gtk::Box.new(:vertical)
		seat_box.add(@coach).add(@business).add(@first)
		
		top_box = Gtk::Box.new(:horizontal)
		top_box.add(flight_box).add(seat_box)
		
		main_box = Gtk::Box.new(:vertical)
		main_box.add(top_box).add(purchase).add(@result)
		
		add(main_box)
		show_all
	end
	
	def cmd_purchase
		text = @city
		if @first.active?
			text += ": первый класс"
		elsif @business.active?
			text += ": бизнес класс"
		elsif @coach.active?
			text += ": эконом класс"
		end
		text += ", обратный билет " if @round_trip.active?
		@result.text = text
	end
end

Gtk.init
TicketWindow.new
Gtk.main