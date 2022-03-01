extends Area2D

export (int) var speed = 350
var velocity = Vector2()
var screensize = Vector2(480, 720)

func _ready():
	pass # Replace with function body.

# определяем движение
func get_input():
	velocity = Vector2()
#	увеличиваем вектор на 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
#	как только увеличен вектор, т.е. отличен от нуля - умножаем на скорость
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

# вызывается каждый кадр
func _process(delta):
	get_input()
	position += velocity * delta
#	ограничиваем движение игрока
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
