extends NinePatchRect

@onready var label: Label = $Label

func _ready() -> void:
	EventBus.citizen_health_changed.connect(_on_health_change)
	
	
func _on_health_change(new_amount: int):
	label.text = str(new_amount)
