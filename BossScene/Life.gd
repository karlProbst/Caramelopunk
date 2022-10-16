extends Node2D


onready var h1 = $CanvasLayer/Life/h1
onready var h2 = $CanvasLayer/Life/h2
onready var h3 = $CanvasLayer/Life/h3
onready var caramelo = $caramelo
onready var coin_counter = $CanvasLayer/Coin/Label
onready var bar = $CanvasLayer2/BossLife/bar
onready var boss = $punk
onready var death_index = $death
onready var death = $death/Death
onready var death_message = $death/Message


var color = 1
var color2 = 0
func _ready():
	pass



func _physics_process(delta):
	if(boss.life<=0):
		get_tree().root.get_child(0).death()
				
	bar.rect_size.x = 1085 * boss.life / boss.max_life
	coin_counter.text = str(caramelo.coin)
	match(caramelo.life):
		0:
			if(color2>5):
				get_tree().root.get_child(0).death()
			color-=delta
			color2+=delta
			death_index.z_index=10
			death.modulate=Color(color,color,color,1)
			death_message.modulate=Color(1,1,1,color2)
			h1.modulate = Color(0,0,0,1)
			h2.modulate = Color(0,0,0,1)
			h3.modulate = Color(0,0,0,1)
		1:
			h1.modulate = Color(1,1,1,1)
			h2.modulate = Color(0,0,0,1)
			h3.modulate = Color(0,0,0,1)
		2:
			h1.modulate = Color(1,1,1,1)
			h2.modulate = Color(1,1,1,1)
			h3.modulate = Color(0,0,0,1)
		3:
			h1.modulate = Color(1,1,1,1)
			h2.modulate = Color(1,1,1,1)
			h3.modulate = Color(1,1,1,1)
