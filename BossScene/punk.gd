extends KinematicBody2D

var bullet_scene = load("res://BossScene/Bullet.tscn")
onready var rotator = $rotator
onready var idle_timer = $Idle_timer

#STATS
var life:=200.0
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
var vel = 50
var state = IDLE
func _ready():
	emit_signal("player_stats_changed", self)
	pass 



func _process(delta):
	match state:
		IDLE:
			pass
		SPECIAL:
			roundShoot()
		WALKING:
		
			if(position.distance_to(new_pos)>10):
				
		
				if(position.x<new_pos.x):
					position.x+=(position.x-new_pos.x)/1*delta
				if(position.x>new_pos.x):
					position.x-=(position.x-new_pos.x)/1*delta
				if(position.y<new_pos.y):
					position.y+=(position.y-new_pos.y)/1*delta
				if(position.y>new_pos.y):
					position.y-=(position.y-new_pos.y)/1*delta
			else:
				
				idle_timer.start()
				state=TOMOVE
		TOMOVE:
			new_pos=Vector2(rng.randi_range(0,1920/8),rng.randi_range(0,1080/8))
			new_pos.x+=(1920/3)
			new_pos.y+=(1080/3)
			print(new_pos)
			state=WALKING
	var new_life = min(life + life_recovery * delta, max_life)
	if new_life != life:
		life = new_life
		emit_signal("player_stats_changed", self)
	
	
func roundShoot():
	rotator.rotate(rotation_rate)
	var b = bullet_scene.instance()
	#constructor(position,rotation,damage,size,vel,tgroup,side):
<<<<<<< HEAD
	b.constructor(self.position,rotator.rotation,1,2,2.5,"Player",-1)
=======
	b.constructor(self.position,rotator.rotation,50,2,2.5,"Player",-1)


>>>>>>> refs/remotes/origin/main
	get_parent().add_child(b)
func hit(damage):
	life-=damage
	print("ai")

func _on_Idle_timer_timeout():
	state=TOMOVE
