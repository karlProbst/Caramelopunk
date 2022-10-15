extends Node

onready var front_tile_01 = $FrontTile_01
onready var front_tile_02 = $FrontTile_02
onready var front_tile_03 = $FrontTile_03
onready var front_tile_04 = $FrontTile_04
onready var front_tile_05 = $FrontTile_05

var vel := 5.0

var rng = RandomNumberGenerator.new()

onready var tiles_array = [front_tile_01,front_tile_02,front_tile_03,front_tile_04,front_tile_05]

func _ready():
	pass

func _process(delta):
	
	for tile in tiles_array:
		tile.position.x -= vel
		tile.frame = rng.randi_range(0,3)
		if tile.position.x < 0:
			tile.position.x = 2400

func front_tile_controller():
	pass

func back_tile_controller():
	pass
