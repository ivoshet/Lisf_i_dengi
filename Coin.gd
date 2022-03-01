extends Area2D
var screensize : Vector2

func _ready():
	pass 
	
#	действие при столкновении
func pickup():
	queue_free()
	
	
