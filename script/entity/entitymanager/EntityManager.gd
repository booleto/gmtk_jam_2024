extends Node2D
class_name EntityManager

@onready var build_utils: BuildUtils = $BuildUtils
@onready var resource_utils: ResourceUtils = $ResourceUtils

var turn : int = 1

func end_turn():
	EventBus.turn_end_event.emit(turn)
	print_current_resources()
	prints("______________________ END OF TURN ", turn, " ______________________")
	turn += 1

func pause_game():
	EventBus.pause_event.emit(true)
	
func resume_game():
	EventBus.pause_event.emit(false)
	
func purchase_new_building(position: Vector2, building : BuildingData) -> bool:
	if not resource_utils.try_fulfill(building.cost):
		return false
	
	build_utils.place_building_global(position, building)
	return true


func print_current_resources():
	var res = resource_utils.resource
	prints("______________________ CURRENT RESOURCES ______________________")
	prints("health: ", res.health, " population: ", res.population, " mood: ", res.mood, " money: ", res.money)


func _on_build_utils_building_built(building: Building) -> void:
	EventBus.turn_end_event.connect(building.on_turn_end)
