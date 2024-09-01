extends Label
class_name EventDataCounter

@export var connected_signal : EventBus.SignalIndex
@export var tween_speed : float
@export var tween_max_duration : float

var tween: Tween

func _ready() -> void:
	EventBus.signal_map[connected_signal].connect(_on_change)
	
	
func _on_change(new_amount: int) -> void:
	var old_amount := int(text)
	if tween:
		tween.kill()
	tween = create_tween()
	var duration: float = min(abs(new_amount - old_amount) / tween_speed, tween_max_duration)
	tween.tween_method(set_label_text, old_amount, new_amount, duration)

func set_label_text(new_amount: int) -> void:
	text = str(new_amount)
