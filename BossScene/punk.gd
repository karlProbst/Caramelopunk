extends KinematicBody2D

var bullet_scene = load("res://BossScene/Bullet.tscn")
onready var rotator = $rotator

#STATS
var life:=200.0
var max_life:=200.0
var life_recovery:=1.0

signal player_stats_changed

export var rotation_rate = 30


func _ready():
	emit_signal("player_stats_changed", self)
	pass 



func _process(delta):
	var new_life = min(life + life_recovery * delta, max_life)
	if new_life != life:
		life = new_life
		emit_signal("player_stats_changed", self)
	
	rotator.rotate(rotation_rate)
	var b = bullet_scene.instance()
	#constructor(position,rotation,damage,size,vel,tgroup,side):
	b.constructor(self.position,rotator.rotation,50,2,2.5,"Player",-1)


	get_parent().add_child(b)

func hit(damage):
	life-=damage
	print("ai")
	
