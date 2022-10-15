extends KinematicBody2D

var bullet_scene = load("res://BossScene/Bullet.tscn")
onready var rotator = $rotator


export var rotation_rate = 30


func _ready():
	pass 



func _process(delta):
	rotator.rotate(rotation_rate)
	var b = bullet_scene.instance()
	#constructor(position,rotation,damage,size,vel,tgroup,side):
	b.constructor(self.position,rotator.rotation,50,2,2.5,"Player",-1)
	

	get_parent().add_child(b)

func hit(damage):
	print("ai")
	
