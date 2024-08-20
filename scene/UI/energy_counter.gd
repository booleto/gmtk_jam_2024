extends NinePatchRect
var tween: Tween
@onready var label: Label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.energy_changed.connect(on_population_update)

func on_population_update(new_amount: int): 
	var old_amount := int(label.text)
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_method(set_label_text, old_amount, new_amount, abs(new_amount - old_amount) / 30.0)

func set_label_text(new_amount: int):
	label.text = str(new_amount)
