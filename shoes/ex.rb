require 'green_shoes'

Shoes.app do
	background white..yellow
	border(orange, strokewidth: 5)
	fill blue
	stack(margin: 8) do
		title('Меню', align: "center", stroke: orange, font: "Trebuchet MS")
		@button_1 = button 'Кнопка 1'
		@button_2 = button 'Кнопка 2'
		@button_3 = button 'Кнопка 3'
		@note = para strong('Нажмите кнопку'),"\nвыше"

		@button_1.click do
			@note.replace 'Спасибо'
		end
		@button_2.click do
			@note.replace 'Спасибо'
		end
		@button_3.click do
			@note.replace 'Спасибо'
		end
	end
	rect(left: 200, top: 10, width: 30)
	arrow(left: 200, top: 40, width: 30)
end