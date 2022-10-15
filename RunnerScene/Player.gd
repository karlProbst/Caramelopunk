extends KinematicBody2D

var jumpspeed = 2000
var fall_speed = 80
var vel := Vector2()

func _ready():
	pass

func _physics_process(delta):
	
	if Input.is_action_pressed("Action") && is_on_floor():
		vel.y -= jumpspeed

	vel.y += fall_speed

	move_and_slide(vel,Vector2.UP)
