extends Node
class_name Building

@export var building_name : String
var building_data : Resource # INJECT THIS
var building_effect : BuildingEffect

signal emit_effect(building_effect)

func _ready():
	pass

func on_turn_end():
	emit_effect.emit()
