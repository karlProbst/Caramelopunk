extends Node2D

# In this script, "global" variables will be stored

onready var boss_scene = load("res://BossScene/Boss.tscn")
onready var runner_scene = load ("res://RunnerScene/runnerscene.tscn")

var boss_level
var runner_level

var loaded_scene = null

var coins_count := 0
onready var button_boss = $button_boss
onready var button_runner = $button_runner

#STATS
var stat_firerate=0
var stat_shield=0
var stat_projectiles=0
var stat_missile=0


func _ready():
	pass
	
	
func death():
	loaded_scene.queue_free()
	loaded_scene = null
	
func _process(delta):
	
	if Input.is_action_just_pressed("ui_home") && loaded_scene != null:
		loaded_scene.queue_free()
		loaded_scene = null
	
	elif (button_boss.is_pressed()) && loaded_scene == null:
		boss_level = boss_scene.instance()
		add_child(boss_level)
		loaded_scene = boss_level
		
	elif (button_runner.is_pressed()) && loaded_scene == null:
		runner_level = runner_scene.instance()
		add_child(runner_level)
		loaded_scene = runner_level
	
	
