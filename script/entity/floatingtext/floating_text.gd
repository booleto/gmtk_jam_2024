extends Node2D

@export var speed : float
@export var text: String

func _ready() -> void:
	$Label.text = text

func _process(delta: float) -> void:
	position.y -= delta * speed

func _on_timer_timeout() -> void:
	queue_free()
