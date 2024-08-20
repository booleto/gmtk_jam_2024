extends Node2D
class_name TextSpawner

var text_scene : PackedScene = preload("res://scene/entity/FloatingText.tscn")

func spawn_text(position: Vector2, text: String):
	var new_text: Node2D = text_scene.instantiate()
	new_text.text = text
	add_child(new_text)
	new_text.position = position
