extends Node
class_name Building

@export var building_name: String
var building_data: Resource # INJECT THIS
var building_effect: BuildingEffect

signal apply_effect(effect: BuildingEffect)

func _ready():
	pass

func on_turn_end():
	apply_effect.emit(building_effect)
