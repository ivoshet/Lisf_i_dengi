extends Node
onready var main_scene = $Main

func _ready():
#	запускает таймер после инициализации
	$Timer.start()
	remove_child(main_scene)
	$Tween.interpolate_property(
		$Sprite, 
		'scale',
		$Sprite.scale,
		$Sprite.scale * 0,
		5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	$Tween.start()

#  таймер истек - вызываем сцену
func _on_Timer_timeout():
	add_child(main_scene)
	
	
