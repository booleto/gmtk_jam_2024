extends Container

@onready var animation_player = $AnimationPlayer

func _on_mouse_entered() -> void:
	print("playing animation")
	animation_player.play("inspect")
	pass # Replace with function body.

func _gui_input(event: InputEvent) -> void:
	print(event)
