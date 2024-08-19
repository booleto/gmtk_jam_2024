extends Container
class_name CardUI

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tooltip_panel: Control = $Control
@onready var tooltip: Label = $Control/PanelContainer/MarginContainer/Label
@onready var sprite: Sprite2D = $Sprite2D

@export var card : Card

func _ready() -> void:
	tooltip_panel.hide()
	load_card_data(card)

func load_card_data(card: Card):
	tooltip.text = card.tooltip
	sprite.frame = card.frame

func _on_mouse_entered() -> void:
	#print("playing animation")
	animation_player.play("inspect")

#func _gui_input(event: InputEvent) -> void:
	#print(event)


func _on_mouse_exited() -> void:
	#print("reset animation")
	if animation_player.is_playing():
		animation_player.pause()
		animation_player.play("inspect", -1, -1)
	else:
		animation_player.play_backwards("inspect")
