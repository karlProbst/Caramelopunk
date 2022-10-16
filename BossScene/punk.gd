extends KinematicBody2D

var bullet_scene = load("res://BossScene/Bullet.tscn")
onready var rotator = $rotator
onready var idle_timer = $Idle_timer
onready var fire_timer = $Fire_timer

#STATS
var life=200
var max_life:=200.0
var life_recovery:=1.0

signal player_stats_changed

export var rotation_rate = 30
var rng = RandomNumberGenerator.new()
var new_pos = Vector2()
enum {
	IDLE,
	SPECIAL,
	WALKING,
	TOMOVE
}
var lock=0
var vel = 200
var state = IDLE
func _ready():
	emit_signal("player_stats_changed", self)
	pass 
	fire_timer.start()


func _process(delta):
	if(life<max_life/1.5 and lock==0):
		vel=300
	if(life<max_life/2 and lock==0):
		idle_timer.set_wait_time(0.45)
		vel=400
		fire_timer.set_wait_time(0.1)
		lock+=1
	if(life<max_life/3 and lock==1):
		idle_timer.set_wait_time(0.65)
		vel=500
		fire_timer.set_wait_time(0.01)
		lock+=1
	match state:
		IDLE:
			roundShoot()
		SPECIAL:
			roundShoot()
		WALKING:
		
			if(position.distance_to(new_pos)>10):
				
		
				if(position.x<new_pos.x):
					position.x+=vel*delta
				if(position.x>new_pos.x):
					position.x-=vel*delta
				if(position.y<new_pos.y):
					position.y+=vel*delta
				if(position.y>new_pos.y):
					position.y-=vel*delta
			else:
				
				idle_timer.start()
				state=IDLE
		TOMOVE:
			new_pos=Vector2(rng.randi_range(0,1920/2),rng.randi_range(0,1080/2))
			new_pos.x+=(1920/2)
			new_pos.y+=(50)
			
			state=WALKING
	var new_life = min(life + life_recovery * delta, max_life)
	if new_life != life:
		life = new_life
		emit_signal("player_stats_changed", self)
	
	
func roundShoot():
	rotator.rotate(rotation_rate)
	var b = bullet_scene.instance()
	#constructor(position,rotation,damage,size,vel,tgroup,side):
	b.constructor(self.position,rotator.rotation,2+(vel/100),3,vel/50,"Player",-1)

	get_parent().add_child(b)
func shoot():
	var b = bullet_scene.instance()
	#constructor(position,rotation,damage,size,vel,tgroup,side):
	b.constructor(self.position,rotation,1,10,vel/40,"Player",-1)
	get_parent().add_child(b)
func hit(damage):
	life-=damage


func _on_Idle_timer_timeout():
	state=TOMOVE

func _on_Fire_timer_timeout():
	shoot()
	
	
