extends CanvasLayer
#экспорт сигнала наружу
signal start_game

# обновляем счет
func update_score(value):
	$MarginContainer/ScoreLabel.text = str(value)

# обновляем таймер
func update_timer(value):
	$MarginContainer/TimeLabel.text= str(value)
	
# показываем сообщение на 2 секунды
func show_message(text):
	$MessageLabel.text =  text
	$MessageLabel.show()
	$MessageTimer.start()

# запуск таймера
func _on_MessageTimer_timeout():
	$MessageLabel.hide()

# нажатие кнопки
func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
#	испускаем сигнал, что игра началась
	emit_signal("start_game")
	
# показываем Game Over
func show_game_over():
	show_message("Game Over")
#	задержка на 2 секунды при помощи таймера
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Coin Dash!"
	$MessageLabel.show()
