extends CanvasLayer
#экспорт сигнала наружу
signal start_game
var game_over_var = false
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
	start_game()
	
	
# показываем Game Over
func show_game_over():
	show_message("Game Over")
#	задержка на 2 секунды при помощи таймера
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Coin Dash!"
	$MessageLabel.show()
#	if Input.is_action_pressed("start_space"):
#		start_game()

func start_game():
	$StartButton.hide()
	$MessageLabel.hide()
#	испускаем сигнал, что игра началась
	emit_signal("start_game")


#func _process(delta): 
#	if game_over_var == true:
#		if Input.is_action_pressed("start_space"):
#			start_game()
