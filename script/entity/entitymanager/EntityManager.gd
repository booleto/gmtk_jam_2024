extends Node2D
class_name EntityManager


@onready var build_utils : BuildUtils = $BuildUtils


func end_turn():
	EventBus.turn_end_event.emit()

func pause_game():
	EventBus.pause_event.emit(true)
	
func resume_game():
	EventBus.pause_event.emit(false)


func _on_build_utils_building_built(building: Building) -> void:
	EventBus.turn_end_event.connect(building.on_turn_end)
