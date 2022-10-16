extends RigidBody2D

onready var target = get_node("../punk")

onready var ray = get_node("RayCast2D")



var damage := 10
var size := 10
var vel = 10
var group ="Enemy"
var side = 1

func _ready():
	pass 

func constructor(position,rotation,damage,size,vel,tgroup,side):
	self.position=position
	self.rotation=rotation
	self.damage=damage
	self.size=size
	self.vel=vel
	self.group=tgroup
	self.side=side
	self.scale*=size

func _integrate_forces(delta):
	
	look_at(target.global_position)
	var angle = rotation
	apply_central_impulse(Vector2(cos(angle), sin(angle)) * 30)
	
func _process(delta):
	ray.force_raycast_update()
	if ray.is_colliding() and ray.get_collider().is_in_group("Enemy"):
		ray.get_collider().hit(60)
		queue_free()
		
	




