extends Area2D
# обозначаем какие сигналы будут от объекта
signal pickup
signal hurt

export (int) var speed = 350
var velocity : Vector2
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
#	выбор анимации в зависимости от направления
	if velocity.length() > 0:
		get_node("AnimatedSprite").animation = "run"
		get_node("AnimatedSprite").flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "idle"
		
#	задать страртовые позиции
func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"
	
# задать состояние столкновения в т.ч уничтожение процесса для данного объекта
func die():
	$AnimatedSprite.animation = "hurt"
#	уничтожить процесс
	set_process(false)
	
# обработка столкновения с другиму area2d
func _on_Player_area_entered(area):
	if area.is_in_group("coins"):
#		что такое пикап() не знаю
		area.pickup()
		emit_signal("pickup", "coin")
	if area.is_in_group("powerups"):
		area.pickup()
		emit_signal("pickup", "powerup")
	if area.is_in_group("obstacles"):
		emit_signal("hurt")
		die()
