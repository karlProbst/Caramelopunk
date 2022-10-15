extends KinematicBody2D

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
			self.scale.y = 1
		CROUCH:
			self.scale.y = .5
		JUMP:
			jump()
			self.scale.y = 1
		FALLING:
			vel.y += fall_speed

	move_and_slide(vel,Vector2.UP)

func crouch():
	pass
func jump():
	vel.y = 0
	vel.y -= jumpspeed
