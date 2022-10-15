extends KinematicBody2D

#STATS
var life:=200
#se for zero a municao e infinita
var weapon_automatic:=5
var weapon_rate:=0.3
var weapon_bullets:=1
#em graus
var weapon_spread:=10
var max_vel:=300
var accel:=max_vel/3


#------------------------------------
var lock = false
var bullets_left = weapon_automatic

onready var timer=$Timer

var vel:=Vector2.ZERO


enum {
	IDLE,
	RUN, 
	BARK
	}

var state := RUN

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	match state:
		IDLE:
			pass
		RUN:
			pass
		BARK:
			pass
#MOVEMENT---------------------------------------------
	if Input.is_action_pressed("ui_right"):
		if vel.x<max_vel:
			vel.x+=accel*2
	if Input.is_action_pressed("ui_left"):
		if vel.x>-max_vel:
			vel.x-=accel*2
	if Input.is_action_pressed("ui_up"):
		if vel.y>-max_vel:
			vel.y-=accel*2
	if Input.is_action_pressed("ui_down"):
		if vel.y<max_vel:
			vel.y+=accel*2

	if vel.x>0:
		vel.x-=accel
	if vel.x<0:
		vel.x+=accel
	if vel.y>0:
		vel.y-=accel
	if vel.y<0:
		vel.y+=accel
	move_and_slide(vel,Vector2.UP)
#----------------------------------------------------
	if !Input.is_action_pressed("ui_accept"):
		lock=false
		bullets_left=weapon_automatic
		timer.stop()
	if Input.is_action_pressed("ui_accept"):
		
		#shoot()
		if(bullets_left>0 and timer.time_left<=0.1):
			shoot()
			bullets_left-=1
			timer.start(weapon_rate)
			
		else:
			lock = true
		
	
func shoot():
	print("shoot!")

func _on_Timer_timeout():
	timer.start(weapon_rate)
