extends Node


enum {
	IDLE, RUN, BARK
	}

var state := RUN

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	match state:
		IDLE:
			print_debug("idle")
		RUN:
			print_debug("run")
		BARK:
			print_debug("bark")
