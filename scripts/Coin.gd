extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var coinlabel = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	coinlabel.text=str(get_tree().root.get_child(0).coins_count)



