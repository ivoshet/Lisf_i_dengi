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
	
#	действие при столкновении
func pickup():
	monitoring = false
	$Tween.start()
	
func _on_Tween_tween_all_completed():
	queue_free()
	
func _on_Powerup_area_entered(area):
	pass # Replace with function body.

# время жизни чудо-монеты
func _on_LifeTime_timeout():
	queue_free()
