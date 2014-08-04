# encoding: utf-8

require 'Qt'

app = Qt::Application.new(ARGV)
str = Time.now.strftime("Сегодня %B %d, %Y")
label = Qt::Label.new(str)
label.show
app.exec