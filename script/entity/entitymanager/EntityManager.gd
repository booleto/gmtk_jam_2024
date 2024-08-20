extends Node2D
class_name EntityManager

@onready var build_utils: BuildUtils = $BuildUtils
@onready var resource_utils: ResourceUtils = $ResourceUtils
@onready var card_manager: CardManager = $CardManager
@onready var status_manager: StatusManager = $StatusManager
@onready var camera: Camera2D = $Camera2D
@onready var text_spawner: TextSpawner = $TextSpawner

func _ready():
	camera.position = build_utils.cell_size * build_utils.grid_bounds / 2
	EventBus.turn_end_event.emit(0)
	resource_utils.quota_fullfilled.connect(_on_quota_finish)
	resource_utils.resource = CityResource.new(30, 50, 50, 50)
	
	#for name in card_manager.card_starters:
		#var card = card_manager.cards[name]
		#var i = card_manager.card_starters[name]
		#if i == null: continue
		#for j in range(i):
			#deck.append(card)
	for i in range(level * 2):
		name = card_manager.card_starters.keys().pick_random()
		card_manager.deck.append(card_manager.cards[name])
	

static var level: int = 1
var turn : int = 1

func end_turn():
	EventBus.turn_end_event.emit(turn)
	var penalty = status_manager.get_penalty()
	resource_utils.apply_penalty(penalty)
	
	print_current_resources()
	prints("______________________ END OF TURN ", turn, " ______________________")
	turn += 1

func pause_game():
	EventBus.pause_event.emit(true)
	
func resume_game():
	EventBus.pause_event.emit(false)
	
func purchase_new_building(position: Vector2, building : BuildingData) -> bool:
	if not resource_utils.able_to_fulfill(building.cost):
		EventBus.not_enough_resources.emit()
		text_spawner.spawn_text(get_global_mouse_position(), "Insufficient materials!")
		return false
		
	if build_utils.place_building_global(position, building):
		resource_utils.try_fulfill(building.cost)
		return true
	else:
		text_spawner.spawn_text(get_global_mouse_position(), "Invalid placement!")
		EventBus.not_valid_building_placement.emit()
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


func spawn_text_at_mouse(text: String):
	text_spawner.spawn_text(get_global_mouse_position(), text)

func _on_quota_finish():
	#print("YAYA")
	spawn_text_at_mouse("Quota Fullfilled")
	await get_tree().create_timer(4).timeout
	LevelLoader.level_up()

#func get_initial_deck(deck: Dictionary):
	#print("fuck")
	#for card: Card in deck.keys():
		#prints(card.card_name, deck[card])
