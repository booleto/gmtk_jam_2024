extends Node

@export
var building_data : Resource
var building_effect : BuildingEffect

signal emit_effect(building_effect)

func on_turn_end():
	emit_effect.emit()
