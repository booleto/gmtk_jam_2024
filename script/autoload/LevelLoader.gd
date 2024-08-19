extends Node

var LEVEL : PackedScene = load("res://level/demo_level.tscn")
var MAIN_MENU : PackedScene
var CREDITS : PackedScene

var current_level
var current_deck

func load_scene(level):
	get_tree().change_scene_to_packed(level)
	#get_tree()
	# inject data
	#get_tree().
