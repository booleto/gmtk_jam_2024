extends Node
class_name BuildUtils

signal building_built()

@export var building_node : PackedScene
@export var building_resource : BuildingData
@export var tile_layer : TileMapLayer
@export var grid_bounds : Vector2

var cell_size : Vector2
var space_available : Array = []

func _ready() -> void:
	cell_size = tile_layer.tile_set.tile_size
		
	for i in range(grid_bounds.x):
		space_available.append([])
		for j in range(grid_bounds.y):
			space_available[i].append(null)


func place_building(position : Vector2, building_data):
	if not is_position_available(position):
		return
	var new_building = building_node.instantiate()
	assert(new_building is Building)
	new_building.building_data = building_data
	
	
	
func destroy_building(position : Vector2):
	pass


func is_position_available(position : Vector2):
	pass
	
	
func get_building_in_position(position: Vector2):
	pass
	
