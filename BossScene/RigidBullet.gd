extends RigidBody2D

onready var target = get_node("../punk")






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
	
	pass
	
func _on_Area2D_body_entered(body):
	if body.is_in_group(group):
		body.hit(damage)


func _on_RigidBody2D_body_entered(body):
	if body.is_in_group(group):
		body.hit(damage)


