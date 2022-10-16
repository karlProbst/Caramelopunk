extends RigidBody2D

onready var target = get_node("../caramelo")



func _integrate_forces(delta):
	
	look_at(target.global_position)
	var angle = rotation
	apply_central_impulse(Vector2(cos(angle), sin(angle)) * 30)
