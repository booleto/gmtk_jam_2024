extends NinePatchRect

@onready var label: Label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.energy_changed.connect(on_population_update)

func on_population_update(new_amount: int): 
	label.text = str(new_amount)
