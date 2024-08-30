extends Node
class_name Level

@onready var entity_manager: EntityManager = %EntityManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var deck = LevelLoader.current_deck
	entity_manager.set_deck(deck)
	entity_manager.resource_utils.quota = LevelLoader.current_quota

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
