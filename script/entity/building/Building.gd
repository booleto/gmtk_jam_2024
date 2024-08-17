extends Node
class_name Building

signal emit_effect(building_effect)

@onready var sprite : Sprite2D = get_node("Sprite2D")
@export var building_data : BuildingData

var grid_position : Vector2i
var building_name : String
var building_effect : BuildingEffect
var building_size : Vector2i

func _ready():
	building_name = building_data.building_name
	building_effect = building_data.effect
	building_size = building_data.size


func on_destroy():
	queue_free()
	

func on_turn_end():
	emit_effect.emit(building_effect)
