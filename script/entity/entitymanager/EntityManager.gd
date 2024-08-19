extends Node2D
class_name EntityManager

@onready var build_utils: BuildUtils = $BuildUtils
@onready var resource_utils: ResourceUtils = $ResourceUtils
@onready var card_manager: CardManager = $CardManager
@onready var camera: Camera2D = $Camera2D

func _ready():
	camera.position = build_utils.cell_size * build_utils.grid_bounds / 2
	

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
	if not resource_utils.able_to_fulfill(building.cost):
		return false
		
	if build_utils.place_building_global(position, building):
		resource_utils.try_fulfill(building.cost)
		return true
	else:
		return false
	
	
func get_city_resource() -> CityResource:
	return resource_utils.resource


func get_energy() -> int:
	return card_manager.energy


func print_current_resources():
	var res = resource_utils.resource
	prints("______________________ CURRENT RESOURCES ______________________")
	prints("health: ", res.health, " population: ", res.population, " mood: ", res.mood, " money: ", res.money)


func play_card_in_hand(index: int) -> bool:
	var card_success = card_manager.play_card(index)
	if card_success:
		card_manager.print_hand()
		end_turn()
		return true
	return false


func _on_build_utils_building_built(building: Building) -> void:
	EventBus.turn_end_event.connect(building.on_turn_end)
