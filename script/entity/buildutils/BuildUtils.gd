extends Node
class_name BuildUtils

signal building_built(building: Building)

@export var tile_layer : TileMapLayer
@export var grid_bounds : Vector2

var cell_size : Vector2
var building_placement : Array = []

func _ready() -> void:
	#cell_size = tile_layer.tile_set.tile_size
	#cell_size = Vector2(10, 10)
	grid_bounds = Vector2(10, 10)
	
	for i in range(grid_bounds.x):
		building_placement.append([])
		for j in range(grid_bounds.y):
			building_placement[i].append(null)
			
	#print(is_placement_valid(Vector2i(9, 0), Vector2i(3, 3)))
	#place_building_test(Vector2i(5, 5), Vector2i(4, 4))
	#print_placement()
	


func place_building(position : Vector2, building_data : BuildingData) -> void:
	if not is_placement_valid(position, building_data.size):
		return
	var new_building : Building = building_data.scene.instantiate()
	new_building.building_data = building_data
	add_sibling(new_building)
	var size: Vector2i = building_data.size
	
	for i in range(size.x):
		for j in range(size.y):
			building_placement[i + position.x][j + position.y] = new_building
			
	building_built.emit(new_building)
	
	
func place_building_test(position: Vector2i, size: Vector2i) -> void:
	if not is_placement_valid(position, size):
		return
	for i in range(size.x):
		for j in range(size.y):
			building_placement[i + position.x][j + position.y] = true
	
	
func destroy_building(pos : Vector2) -> void:
	if is_position_available(pos):
		return
		
	var building: Building = building_placement[pos.x][pos.y]
	var position : Vector2i = building.grid_position
	var building_size : Vector2i = building.building_size
	building.on_destroy()
	
	for i in range(building_size.x):
		for j in range(building_size.y):
			building_placement[position.x + i][position.y + j] = null
	
	

func is_position_available(pos : Vector2i) -> bool:
	if not (0 <= pos.x and pos.x < grid_bounds.x):
		return false
	if not (0 <= pos.y and pos.y < grid_bounds.y):
		return false
	if building_placement[pos.x][pos.y] == null:
		return true
	return false


func is_placement_valid(pos: Vector2i, size: Vector2i) -> bool:
	for i in range(size.x):
		for j in range(size.y):
			if not is_position_available(pos + Vector2i(i, j)):
				return false
	return true
	
	
func get_building_in_position(pos: Vector2i) -> Building:
	if is_position_available(pos):
		return null
	return building_placement[pos.x][pos.y]
	
	
func print_placement() -> void:
	for i in range(grid_bounds.x):
		var line = ""
		for j in range(grid_bounds.y):
			var tile = 1 if building_placement[i][j] != null else 0
			line = line + str(tile)
		print(line)
