extends CanvasLayer
signal start_game

# обновляем счет
func update_score(value):
	$MarginContainer/ScoreLabel.text = str(value)

# обновляем таймер
func update_timer(value):
	$MarginContainer/TimeLabel.txt = str(value)
