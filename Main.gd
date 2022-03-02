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
	new_game()
	
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
	
func spawn_coins():
	for i in range(4 + level):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(rand_range(0, screensize.x),
		rand_range(0, screensize.y))

# проверяем каждый кадр не пора ли начать новый уровень		
func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		time_left += 5
		spawn_coins()
	
	


