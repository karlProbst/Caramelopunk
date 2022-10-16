extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	position.x -= get_parent().vel


func _on_Collectable_body_entered(body):
	if body.has_method("_interact"):
		get_tree().root.get_child(0).coins_count += 1
		queue_free()
