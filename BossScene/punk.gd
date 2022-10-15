extends KinematicBody2D

var bullet_scene = load("res://BossScene/Bullet.tscn")
onready var rotator = $rotator


export var rotation_rate = 30


func _ready():
	pass 



func _process(delta):
	rotator.rotate(rotation_rate)
	var b = bullet_scene.instance()
	b.position = self.position
	b.rotation=rotator.rotation
	b.position.x-=100
	get_parent().add_child(b)
