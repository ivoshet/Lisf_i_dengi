extends Node

export (PackedScene) var Coin
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

# проверяем каждый кадр не пора ли начать новый уровень		
func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
#		добавляем 5 секунд на каждом уровне
		time_left += 5
		spawn_coins()
	
func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()

func _on_Player_hurt():
	game_over()

func _on_Player_pickup():
	score += 1
	$HUD.update_score(score)
	$CoinSound.play()

func game_over():
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()
	$EndSound.play()
	
