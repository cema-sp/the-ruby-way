# encoding: UTF-8

require 'Qt'

class MyWindow < Qt::Widget
	slots 'somethingClicked(QAbstractButton *)'
	def initialize(parent = nil)
		super(parent)
		
		groupbox = Qt::GroupBox.new("Группа переключателей", self)
		
		radio_1 = Qt::RadioButton.new("Переключатель 1", groupbox)
		radio_2 = Qt::RadioButton.new("Переключатель 2", groupbox)
		check = Qt::CheckBox.new("Флажок",groupbox)
		
		vbox = Qt::VBoxLayout.new
		vbox.addWidget(radio_1)
		vbox.addWidget(radio_2)
		vbox.addWidget(check)
		
		groupbox.setLayout(vbox)
		
		bg = Qt::ButtonGroup.new(self)
		bg.addButton(radio_1)
		bg.addButton(radio_2)
		bg.addButton(check)
		
		connect(bg, SIGNAL('buttonClicked(QAbstractButton *)'),
				self, SLOT('somethingClicked(QAbstractButton *)'))
				
		@label = Qt::Label.new(self)
		
		vbox = Qt::VBoxLayout.new
		vbox.addWidget(groupbox)
		vbox.addWidget(@label)
		
		setLayout(vbox)
	end
	
	def somethingClicked(who)
		@label.setText("Нажато: "+who.className)
	end
end

app = Qt::Application.new(ARGV)
widget = MyWindow.new
widget.show
app.exec