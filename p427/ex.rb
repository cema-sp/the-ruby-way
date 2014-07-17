# encoding: utf-8

require 'fox16'

include Fox

class MenuAndRadioButtonWindow < FXMainWindow
	def initialize(app, title)
		super(app, title, nil, nil, DECOR_TITLE | DECOR_CLOSE)
		
		cola_sizes = %w[Маленькая Стандартная Большая]
		burgers = %w[Чизбургер Гамбургер БигМак]
		default_size = 0
		
		# make menu
		menubar = FXMenuBar.new(self, LAYOUT_SIDE_TOP | LAYOUT_FILL_X)
		
		FXMenuPane.new(self) do |filemenu|
			FXMenuCommand.new(filemenu, "&Выйти\tCtrl-Q") do |cmd|
				cmd.connect(SEL_COMMAND) {app.exit}
			end
			FXMenuCommand.new(filemenu, "&Свернуть\tCtrl-I") do |cmd|
				cmd.connect(SEL_COMMAND) {self.minimize}
			end
			FXMenuTitle.new(menubar, "&Файл", nil, filemenu)
		end
		
		# make radio buttons and group them
		cola_sizes_group = FXGroupBox.new(self, "Выберите Колу: ", 
								LAYOUT_SIDE_TOP | FRAME_GROOVE | 
								LAYOUT_FILL_X)
		@cola_size = FXDataTarget.new(default_size)
		
		cola_sizes.each_with_index do |cola_size, index|
			FXRadioButton.new(cola_sizes_group, cola_size, @cola_size, 
								FXDataTarget::ID_OPTION+index, 
								ICON_BEFORE_TEXT | LAYOUT_SIDE_TOP)
		end
		
		# make list
		FXGroupBox.new(self, "Выберите бургер: ", 
								LAYOUT_SIDE_TOP | FRAME_GROOVE | 
								LAYOUT_FILL_X) do |group|
			FXListBox.new(group, nil, 0, 
							LIST_BROWSESELECT | LAYOUT_FILL_X) do |list|
				burgers.each do |burger|
					list.appendItem(burger)
				end
				list.connect(SEL_COMMAND) do |sender, sel, pos|
					puts burgers[pos]
				end
			end
		end

		
		
	end
end

app = FXApp.new
main = MenuAndRadioButtonWindow.new(app, "Menu Example")

app.create
main.show(PLACEMENT_SCREEN)
app.run