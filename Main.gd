extends Node

export (PackedScene) var Coin
export (PackedScene) var Powerup
export (PackedScene) var Cactus
export (int) var playtime = 30

var level : int
var score : int
var time_left : int
var screensize = Vector2()
var playing : bool = false

# задаем стартовые параметры
func _ready():
	randomize()
#	получаем размеры видимого экрана
	screensize = get_viewport().get_visible_rect().size
#	задаем сцене Player размеры видимого экрана
	$Player.screensize = screensize
#	скрываем игрока до поры до времени
	$Player.hide()
	
# запускаем новую игру
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	spawn_kaktus()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)
	
func spawn_coins():
	for i in range(4 + level):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(rand_range(0, screensize.x),
		rand_range(0, screensize.y))
	$LevelSound.play()
	
# появление кактуса
func spawn_kaktus():
#	for i in range(1 + level):
		var ck = Cactus.instance()
		$CactusContainer.add_child(ck)
		ck.screensize = screensize
		ck.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))

# проверяем каждый кадр не пора ли начать новый уровень		
func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
#		добавляем 5 секунд на каждом уровне
		time_left += 5
		spawn_coins()
		spawn_kaktus()
		$PowerupTimer.wait_time = rand_range(5, 10)
		$PowerupTimer.start()
	
func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()

func _on_Player_hurt():
	game_over()

func _on_Player_pickup(type):
	match type:
		"coin":
			score += 1
			$CoinSound.play()
			$HUD.update_score(score)
		"powerup":
			time_left += 5
			$PowSound.play()
			$HUD.update_timer(time_left)
	
func game_over():
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	for cactus in $CactusContainer.get_children():
		cactus.queue_free()
	$HUD.show_game_over()
	$Player.die()
	$EndSound.play()
	
func _on_PowerupTimer_timeout():
	var p = Powerup.instance()
	add_child(p)
	p.screensize = screensize
	p.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))
	
