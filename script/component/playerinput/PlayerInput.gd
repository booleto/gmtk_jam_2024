extends Node2D

@export var build_utils : BuildUtils
@export var school : BuildingData
@export var market : BuildingData

var entity_manager : EntityManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_parent().ready
	entity_manager = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse = get_global_mouse_position()
	
	if Input.is_action_just_pressed("card1"):
		print("build test 1")
		build_utils.place_building_global(mouse, school)
		#build_utils.print_placement()
		trigger_turn_end()
	
	if Input.is_action_just_pressed("card2"):
		print("build test 2")
		build_utils.place_building_global(mouse, market)
		#build_utils.print_placement()
		trigger_turn_end()
	

func trigger_turn_end():
	print("end turn")
	entity_manager.end_turn()
