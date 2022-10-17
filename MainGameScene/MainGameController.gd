extends Node2D

# In this script, "global" variables will be stored

onready var boss_scene = load("res://BossScene/Boss.tscn")
onready var ending = load("res://end.tscn")
onready var runner_scene = load ("res://RunnerScene/runnerscene.tscn")

var boss_level
var runner_level

var loaded_scene = null

var coins_count := 0

onready var counter_coins = $Coin/Label
onready var audio_gacha_coin = $Audiocoin
onready var button_boss = $button_boss
onready var button_runner = $button_runner
onready var button_gacha = $gacha
onready var button_gacha_number = $gacha/Label2

onready var stat_firerate_label = $stat_firerate/label
onready var stat_projectile_label = $stat_projectile/label
onready var stat_missile_label = $stat_missile/label
onready var stat_shield_label = $stat_shield/label

onready var stat_firerate_gacha_label = $stat_firerate/gacha
onready var stat_projectile_gacha_label = $stat_projectile/gacha
onready var stat_missile_gacha_label = $stat_missile/gacha
onready var stat_shield_gacha_label = $stat_shield/gacha

#STATS
var stat_firerate=0
var stat_shield=0
var stat_projectiles=0
var stat_missile=0

var stat_firerate_gacha=0
var stat_shield_gacha=0
var stat_projectiles_gacha=0
var stat_missile_gacha=0

var gacha_base_value=20
var gacha_value=gacha_base_value
var gacha_multiplier=.05
var times_bought = 0
var gacha_lock = false
var rng = RandomNumberGenerator.new()
func _ready():
	rng.randomize()
	button_gacha_number.text=str(gacha_value)
	
func death():
	loaded_scene.queue_free()
	loaded_scene = null
func win():
	ending = ending.instance()
	add_child(ending)
	loaded_scene = ending
	coins_count+=1000
func _process(delta):
	
	counter_coins.text=str(coins_count)
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
	if (!button_gacha.is_pressed()):
		gacha_lock=false
	if (button_gacha.is_pressed() and coins_count>gacha_value and !gacha_lock):
		audio_gacha_coin.play()
		coins_count-=gacha_value
		times_bought+=1
		gacha_value=gacha_base_value*(1+gacha_multiplier*times_bought)
		gacha_value=int(gacha_value)
		button_gacha_number.text=str(gacha_value)
		var rand = rng.randi_range(1,4)
		match rand:
			1:	
				
				stat_firerate_gacha+=1
				print(str(stat_firerate_gacha)+" "+str(stat_firerate))
			2:
				stat_shield_gacha+=1
			3:
				stat_projectiles_gacha+=1
			4:
				stat_missile_gacha+=1
				
		if stat_firerate_gacha>=3:	
			stat_firerate+=1
			stat_firerate_gacha=0
		if stat_shield_gacha>=3:
			stat_shield+=1
			stat_shield_gacha=0
		if stat_projectiles_gacha>=3:
			stat_projectiles+=1
			stat_projectiles_gacha=0
		if stat_missile_gacha>=3:
			stat_missile+=1
			stat_missile_gacha=0
			
		stat_firerate_label.text = str(stat_firerate)
		stat_projectile_label.text = str(stat_projectiles)
		stat_missile_label.text = str(stat_missile)
		stat_shield_label.text = str(stat_shield)

		stat_firerate_gacha_label.text = str(stat_firerate_gacha)
		stat_projectile_gacha_label.text = str(stat_projectiles_gacha)
		stat_missile_gacha_label.text = str(stat_missile_gacha)
		stat_shield_gacha_label.text = str(stat_shield_gacha)
		#gambiarra pra butotn released
		gacha_lock=true
