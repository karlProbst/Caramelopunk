extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var scroll = 0
var c= 1
var lock
# Called when the node enters the scene tree for the first time.
func _ready():
	lock = 0



func _process(delta):

	#$RichTextLabel.scroll_to_line(scroll)
	
	if ($button_begin.is_pressed() and lock==0):
		
	
		lock = 1
		
	if lock==1:
		c-=delta
		self.modulate= Color(c,c,c,c)
		if(c<0):
			set_global_position(Vector2(1920*2,0))
			lock=2
