extends Node2D

var dano := 10
var tamanho := 10

func _ready():
	pass 


func _process(delta):
	self.position+=Vector2(1,0).rotated(self.rotation)
	if self.position.x>get_viewport_rect().size.x:
		queue_free()
	if self.position.x<0:
		queue_free()
	if self.position.y>get_viewport_rect().size.y:
		queue_free()
	if self.position.y<0:
		queue_free()
func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		body.hit(dano)
		print("hit")
