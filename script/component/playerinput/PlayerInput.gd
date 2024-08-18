extends Node2D

@export var build_utils : BuildUtils
#@export var school : BuildingData
#@export var market : BuildingData
#@export var company : BuildingData
#@export var hospital : BuildingData
#@export var house : BuildingData

var entity_manager : EntityManager
var data: Array[BuildingData] = []

func _init():
	for datum in DirAccess.get_files_at("res://script/resource/building"):
		if datum.ends_with("Data.tres"):
			data.append(load("res://script/resource/building/" + datum) as BuildingData)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_parent().ready
	entity_manager = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for datum in data:
		if Input.is_action_just_pressed(datum.input_action):
			buy_building(datum)

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
