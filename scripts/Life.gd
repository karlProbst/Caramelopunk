extends Container


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var h1 = $"1"
onready var h2 = $"2"
onready var h3 = $"3"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_caramelo_player_stats_changed(var caramelo):
	
	match(caramelo.life):
		0:
			h1.modulate = Color(0,0,0,1)
			h2.modulate = Color(0,0,0,1)
			h3.modulate = Color(0,0,0,1)
		1:
			h1.modulate = Color(1,1,1,1)
			h2.modulate = Color(0,0,0,1)
			h3.modulate = Color(0,0,0,1)
		2:
			h1.modulate = Color(1,1,1,1)
			h2.modulate = Color(1,1,1,1)
			h3.modulate = Color(0,0,0,1)
		3:
			h1.modulate = Color(1,1,1,1)
			h2.modulate = Color(1,1,1,1)
			h3.modulate = Color(1,1,1,1)
