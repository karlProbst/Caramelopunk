extends KinematicBody2D

onready var anim = $AnimatedSprite

var jumpspeed = 1650
var fall_speed = 50
var vel := Vector2()

enum {
	RUN,
	JUMP,
	FALLING,
	CROUCH,
	BARK
}

var state = RUN

func _ready():
	pass

func _physics_process(delta):
	
	jump_input()
	

func jump_input():
	
	
	if is_on_floor():
		state = RUN
		if Input.is_action_pressed("Action"):
			state = CROUCH 
		elif Input.is_action_just_released("Action"):
			state = JUMP
	elif !is_on_floor():
		state = FALLING

	match state:
		RUN:
			anim.play("Run")
		CROUCH:
			anim.play("Crouch")
		JUMP:
			jump()
			anim.play("Jumping")
		FALLING:
			vel.y += fall_speed
			anim.play("Fall")

	move_and_slide(vel,Vector2.UP)

func crouch():
	pass
func jump():
	vel.y = 0
	vel.y -= jumpspeed

func _interact():
	pass
