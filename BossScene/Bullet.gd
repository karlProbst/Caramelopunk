extends Node2D


var dano := 10
var tamanho := 10
func _ready():
	pass 


func _process(delta):
	self.position+=Vector2(1,0).rotated(self.rotation)



func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.hit(dano)
		print("hit")
