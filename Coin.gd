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
#	$Tween.interpolate_property(
#		$AnimatedSprite,
#		'modulate',
#		Color(1,1,1,1),
#		Color(1,1,1,0),
#		$Tween.TRANS_QUAD,
#		$Tween.EASE_IN_OUT
#	)
	
#	действие при столкновении
func pickup():
	monitoring = false
	$Tween.start()
	
func _on_Tween_tween_all_completed():
	queue_free()
