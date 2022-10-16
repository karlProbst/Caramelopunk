extends Node

#This code has the spawn for tiles, obstacles and coins.
#didn't change the name. was afreaid it would break ;(

onready var front_tile_01 = $FrontTile_01
onready var front_tile_02 = $FrontTile_02
onready var front_tile_03 = $FrontTile_03
onready var front_tile_04 = $FrontTile_04
onready var front_tile_05 = $FrontTile_05

onready var obstacle_instance = load("res://RunnerScene/Obstacles/Obstacle.tscn")

var vel := 10.0

var obstacle_spawn_timer = 0 #Counter based on the tiles to spawn obstacles... including enemies
var coin_spawn_timer = 0


var rng = RandomNumberGenerator.new()


onready var tiles_array = [front_tile_01,front_tile_02,front_tile_03,front_tile_04,front_tile_05]

func _ready():
	for tile in tiles_array:
		tile.frame = rng.randi_range(0,3)

func _process(delta):
	front_tile_controller()

func front_tile_controller():
	for tile in tiles_array:
		tile.position.x -= vel
		
		if tile.position.x < 0:
			
			tile.frame = rng.randi_range(0,3)
			tile.position.x = 2400
			obstacle_spawn_timer += 1
			coin_spawn_timer += 1
			if obstacle_spawn_timer >= 5:
				obstacle_spawner()
			if obstacle_spawn_timer >= 6:
				coin_spawner()
			print(obstacle_spawn_timer)

func back_tile_controller():
	pass

func coin_spawner():
	pass

func obstacle_spawner():
	var obstacle = obstacle_instance.instance()
	obstacle.position = Vector2(2400,666)
	self.add_child(obstacle)
	print(obstacle)
	obstacle_spawn_timer = 0
