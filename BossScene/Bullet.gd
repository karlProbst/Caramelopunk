extends Node2D

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

func _process(delta):
	self.position+=Vector2(1*side*vel,0).rotated(self.rotation)
	
	if self.position.x>get_viewport_rect().size.x:
		queue_free()
	if self.position.x<0:
		queue_free()
	if self.position.y>get_viewport_rect().size.y:
		queue_free()
	if self.position.y<0:
		queue_free()
		
func _on_Area2D_body_entered(body):
	if body.is_in_group(group):
		body.hit(damage)
