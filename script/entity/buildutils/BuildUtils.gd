extends Node
class_name BuildUtils

signal building_built(building: Building)

@export var test_building : BuildingData
@export var tile_layer : TileMapLayer
@export var grid_bounds : Vector2i

var cell_size : Vector2
var building_placement : Array[Array] = []

func _ready() -> void:
	cell_size = tile_layer.tile_set.tile_size
	
	for i in range(grid_bounds.x):
		building_placement.append([])
		for j in range(grid_bounds.y):
			building_placement[i].append(null)
			
	#print(is_placement_valid(Vector2i(9, 0), Vector2i(3, 3)))
	#place_building_test(Vector2i(5, 5), Vector2i(1, 2))
	#await get_parent().ready
	#place_building(Vector2i(1, 1), test_building)
	#print_placement()
	#destroy_building(Vector2i(1, 1))
	#print_placement()

func place_building_global(global_pos : Vector2, building_data : BuildingData) -> void:
	var map_pos = tile_layer.local_to_map(global_pos)
	place_building(map_pos, building_data)


func place_building(position : Vector2, building_data : BuildingData) -> void:
	if not is_placement_valid(position, building_data.size):
		return
	var new_building : Building = building_data.scene.instantiate()
	new_building.building_data = building_data
	new_building.grid_position = position
	add_sibling(new_building)
	new_building.position = position * cell_size.x
	new_building.build_utils = self
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
	

func is_position_in_bounds(pos: Vector2i) -> bool:
	return ((0 <= pos.x and pos.x < grid_bounds.x) and (0 <= pos.y and pos.y < grid_bounds.y))


func is_position_available(pos : Vector2i) -> bool:
	if not is_position_in_bounds(pos):
		return false
		
	return building_placement[pos.x][pos.y] == null


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
	

func find_adjacent_builds(pos: Vector2i) -> Array[Building]:
	var build = get_building_in_position(pos)
	if build == null: return []
	var size = build.building_data.size
	
	var start_iter = build.grid_position - Vector2i(1, 1)
	var iter_size = size + Vector2i(2, 2)
	
	var adjs : Array[Building] = []
	for i in range(iter_size.x):
		for j in range(iter_size.y):
			var ipos = Vector2i(i + start_iter.x, j + start_iter.y)
			if is_position_in_bounds(ipos):
				if building_placement[ipos.x][ipos.y] != null and building_placement[ipos.x][ipos.y] not in adjs:
					adjs.append(building_placement[ipos.x][ipos.y])
	return adjs
	
	
func print_placement() -> void:
	for i in range(grid_bounds.x):
		var line = ""
		for j in range(grid_bounds.y):
			var tile = 1 if building_placement[i][j] != null else 0
			line = line + str(tile)
		print(line)


func highlight_cell(pos : Vector2i):
	pass
