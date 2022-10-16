extends Node

#This code has the spawn for tiles, obstacles and coins.
#didn't change the name. was afreaid it would break ;(

onready var front_tile_01 = $FrontTile_01
onready var front_tile_02 = $FrontTile_02
onready var front_tile_03 = $FrontTile_03
onready var front_tile_04 = $FrontTile_04

onready var obstacle_instance = load("res://RunnerScene/Obstacles/Obstacle.tscn")
onready var coin_instance = load("res://RunnerScene/Collectable/Collectable.tscn")

onready var sessions_instance_01 = load("res://RunnerScene/SpawnSessions/SpawnSession01.tscn")
onready var sessions_instance_02 = load("res://RunnerScene/SpawnSessions/SpawnSession02.tscn")
onready var sessions_instance_03 = load("res://RunnerScene/SpawnSessions/SpawnSession03.tscn")
onready var sessions_instance_04 = load("res://RunnerScene/SpawnSessions/SpawnSession04.tscn")
onready var sessions_instance_05 = load("res://RunnerScene/SpawnSessions/SpawnSession05.tscn")
onready var sessions_instance_06 = load("res://RunnerScene/SpawnSessions/SpawnSession06.tscn")
onready var sessions_instance_07 = load("res://RunnerScene/SpawnSessions/SpawnSession07.tscn")
onready var sessions_instance_08 = load("res://RunnerScene/SpawnSessions/SpawnSession08.tscn")

var vel := 10.0

var session_spawn_timer = 5 #Counter based on the tiles to spawn obstacles... including enemies

var session

var rng = RandomNumberGenerator.new()


onready var tiles_array = [front_tile_01,front_tile_02,front_tile_03,front_tile_04]
onready var session_array = [sessions_instance_01,sessions_instance_02,sessions_instance_03,sessions_instance_04,sessions_instance_05,sessions_instance_06,sessions_instance_07,sessions_instance_08]

func _ready():
	for tile in tiles_array:
		tile.frame = rng.randi_range(0,3)

	rng.randomize()

func _process(delta):
	front_tile_controller()

func front_tile_controller():
	for tile in tiles_array:
		tile.position.x -= vel
		
		if tile.position.x < 0:
			session_spawn_timer += 1
			if session_spawn_timer >= 2:
				session_spawner(rng.randi_range(0,7),0)
			tile.frame = rng.randi_range(0,3)
			tile.position.x = 3714

func back_tile_controller():
	pass

func session_spawner(session_number, x_offset):
	
	session = session_array[session_number].instance()
	session.position = Vector2(1920+x_offset,0)
	self.add_child(session)
	session_spawn_timer = 0
	if vel <= 18:
		vel += 0.25
	print(vel)


func obstacle_spawner():
	var obstacle = obstacle_instance.instance()
	obstacle.position = Vector2(2400,840)
	self.add_child(obstacle)

