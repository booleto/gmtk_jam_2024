extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.turn_end_event.connect(on_turn_update)

func on_turn_update(turn):
	text = str(turn)
