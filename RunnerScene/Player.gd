extends KinematicBody2D

onready var anim = $AnimatedSprite
onready var col = $CollisionShape2D

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
	if position.x <= -170:
		get_tree().root.get_child(0).death()

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
			col.position.y = 30
			col.scale.y = 0.5
		JUMP:
			jump()
			anim.play("Jumping")
			col.position.y = -16.5
			col.scale.y = 1
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
