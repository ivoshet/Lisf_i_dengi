extends Area2D
var screensize : Vector2

func _ready():
#	анимация монеты 
	$Tween.interpolate_property(
		$AnimatedSprite, 
		'scale',
		$AnimatedSprite.scale,
		$AnimatedSprite.scale * 3,
		0.3,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
#	создаем задержку между анимациями каждой монеты
	$Timer.wait_time = rand_range(1, 3)
	$Timer.start()
	
#	действие при столкновении
func pickup():
	monitoring = false
	$Tween.start()
	
func _on_Tween_tween_all_completed():
	queue_free()

# таймер задержки между анимациями каждой монеты
func _on_Timer_timeout():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play()
	
func _on_Coin_area_entered(area):
	if area.is_in_group("obstacles"):
		position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))
