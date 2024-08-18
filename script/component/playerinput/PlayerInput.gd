extends Node2D

@export var build_utils : BuildUtils
@export var school : BuildingData
@export var market : BuildingData
@export var company : BuildingData
@export var hospital : BuildingData
@export var house : BuildingData

var entity_manager : EntityManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_parent().ready
	entity_manager = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("card1"):
		buy_building(school)
	
	if Input.is_action_just_pressed("card2"):
		buy_building(market)
	
	if Input.is_action_just_pressed("card3"):
		buy_building(house)
	
	if Input.is_action_just_pressed("card4"):
		buy_building(company)
	
	if Input.is_action_just_pressed("card5"):
		buy_building(hospital)


func trigger_turn_end():
	entity_manager.end_turn()
	

func buy_building(building : BuildingData) -> bool:
	prints("buying: ", building.building_name)
	if entity_manager.purchase_new_building(get_global_mouse_position(), building):
		print("building successfully bought")
		trigger_turn_end()
		return true
	else:
		return false
