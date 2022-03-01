extends Node

export (PackedScene) var Coin
export (int) var playtime = 30

var level : int
var score : int
var time_left : int
var screensize : Vector2
var playing : bool = false

func _ready():
	randomize()
#	получаем размеры видимого экрана
	screensize = get_viewport().get_visible_rect().size
#	задаем сцене Player размеры видимого экрана
	$Player.screensize = screensize
#	скрыываем игрока до поры до времени
	$Player.hide()
	
	


