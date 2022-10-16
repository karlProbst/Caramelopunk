extends KinematicBody2D

#STATS
var life:=3
var max_life:=3
var life_recovery:=1.0
var coin:=200
var max_coin:=200.0
var coin_recovery:=1.0

var stat_dmg = 0

signal player_stats_changed

#se for zero a municao e infinita
var weapon_automatic:=5
var weapon_rate:=0.3
var weapon_bullets:=1
#em graus
var weapon_spread:=10
var max_vel:=600
var accel:=max_vel/3
var bullet_scene = load("res://BossScene/Bullet.tscn")
var missile_scene = load("res://BossScene/rigid_bullet.tscn")
var scaley=scale.y
var scalex=scale.x
var rotationx=rotation
#------------------------------------
var lock = false
var bullets_left = weapon_automatic

onready var sprite = $AnimatedSprite
onready var timer=$Timer
onready var timer2=$Timer2
onready var invincible=$invincible
onready var shield = $shield
var vel:=Vector2.ZERO


enum {
	IDLE,
	RUN, 
	BARK
	}

var state := RUN

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("player_stats_changed", self)
	pass

func _process(delta):
	
	shield.rotation+=delta*3
	var new_coin = min(coin + coin_recovery * delta, max_coin)
	if new_coin != coin:
		coin = new_coin
		emit_signal("player_stats_changed", self)
		
		
	var new_life = min(life + life_recovery * delta, max_life)
	if new_life != life:
		life = new_life
		emit_signal("player_stats_changed", self)

	
	match state:
		IDLE:
			sprite.animation="run"
		RUN:
			sprite.animation="idle"
		BARK:
			pass
#MOVEMENT---------------------------------------------
	if(life>0):
		timer2.wait_time=weapon_rate
		if(vel==Vector2.ZERO):
			state=RUN
		else:
			state=IDLE
		
		#DIAGONAL
		if Input.is_action_pressed("ui_right"):
			scale.x=scalex
			if vel.x<max_vel:
				vel.x+=accel*2
		
		elif Input.is_action_pressed("ui_left"):
			
			if vel.x>-max_vel:
				vel.x-=accel*2
			
		if Input.is_action_pressed("ui_up"):
			if(rotation>rotationx-0.35):
				rotation-=0.5*delta
			if vel.y>-max_vel:
				vel.y-=accel*2
		elif Input.is_action_pressed("ui_down"):
			if(rotation<rotationx+0.23):
				rotation+=0.5*delta
		
			if vel.y<max_vel:
				vel.y+=accel*2
		else:
			rotation=rotationx
	else:
		#DEATH
		sprite.speed_scale=0
		scale.y=-scaley
		shield.modulate = Color(0,0,0,0)
		timer2.wait_time=9999999999999
	if vel.x>0:
		vel.x-=accel
	if vel.x<0:
		vel.x+=accel
	if vel.y>0:
		vel.y-=accel
	if vel.y<0:
		vel.y+=accel
	move_and_slide(vel,Vector2.UP)
	if position.y>get_viewport_rect().size.y:
		position.y=get_viewport_rect().size.y
	if position.y<0:
		position.y=0
	if position.x>get_viewport_rect().size.x:
		position.x=get_viewport_rect().size.x
	if position.x<0:
		position.x=0
		
	
	
#----------------------------------------------------
#shooting
	
	if !Input.is_action_pressed("ui_accept"):
		lock=false
		bullets_left=weapon_automatic
		timer.stop()
	if Input.is_action_pressed("ui_accept"):
		
		#shoot()
		if(bullets_left>0 and timer.time_left<=0.1):
			shoot()
			shootMissile()
			bullets_left-=1
			timer.start(weapon_rate)
			
		else:
			lock = true
		
	
func hit(dano):
	if(invincible.time_left<=0.1):
		life-=dano
		invincible.start(1)
		#fazer var depois
		self.modulate = Color(10,2,2,1)
		


func shootMissile():
	var b = missile_scene.instance()

	#constructor(position,rotation,damage,size,vel,tgroup,side):
	b.constructor(self.position,rotation,1+stat_dmg,1,10,"Enemy",1)
	get_parent().add_child(b)	

func shoot():
	var b = bullet_scene.instance()

	#constructor(position,rotation,damage,size,vel,tgroup,side):
	b.constructor(self.position,rotation,1+stat_dmg,4,10,"Enemy",1)
	get_parent().add_child(b)


func _on_Timer_timeout():
	timer.start(weapon_rate)


func _on_invincible_timeout():
	self.modulate = Color(1,1,1,1)
	
#codigo para implementar na funcao de dano para tirar vida do player
# if life >= 10
# 	life = life - 10
# 	emit_signal("player_stats_changed", self)

#codigo para implementar na funcao de receber moedas para aumentar qtd de moedas do player
# if coin <= 10
# 	coin = coin + 10
# 	emit_signal("player_stats_changed", self)


func _on_Timer2_timeout():
	shoot()