extends Node2D

# In this script, "global" variables will be stored

onready var boss_scene = load("res://BossScene/Boss.tscn")
onready var runner_scene = load ("res://RunnerScene/runnerscene.tscn")

var boss_level
var runner_level

var loaded_scene = null

var coins_count := 0

# In this script, the scenes from the hub, boss and run will be initiated.

func _ready():
	pass
	
	

func _process(delta):

	if Input.is_action_just_pressed("ui_home") && loaded_scene != null:
		loaded_scene.queue_free()
		loaded_scene = null
	
	elif Input.is_action_pressed("ui_up") && loaded_scene == null:
		boss_level = boss_scene.instance()
		add_child(boss_level)
		loaded_scene = boss_level
		
	elif Input.is_action_pressed("ui_down") && loaded_scene == null:
		runner_level = runner_scene.instance()
		add_child(runner_level)
		loaded_scene = runner_level
