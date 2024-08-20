extends Node

var LEVEL : PackedScene = load("res://level/demo_level.tscn")
var MAIN_MENU : PackedScene
var CREDITS : PackedScene

var current_level: int
var current_deck: Dictionary = {
	DataIndex.CARD_BAR: 1,
	DataIndex.CARD_CHRISTMAS: 1,
	DataIndex.CARD_COMPANY: 1,
	DataIndex.CARD_EATERY: 1,
	DataIndex.CARD_HOSPITAL: 1,
	DataIndex.CARD_HOUSE: 1,
	DataIndex.CARD_LOCAL_FEST: 1,
	DataIndex.CARD_MARKET: 1,
	DataIndex.CARD_PUB: 1,
	DataIndex.CARD_SCHOOL: 1,
	DataIndex.CARD_SUPERMARKET: 1
}

#var entity_manager: EntityManager

func reload():
	load_scene(LEVEL)

func load_scene(level):
	get_tree().change_scene_to_packed(level)
	await get_tree().root.ready
	inject_deck(current_deck)
	

func inject_deck(deck: Dictionary):
	var entity: EntityManager = get_tree().root.get_node("/root/Level/EntityManager")
	entity.get_initial_deck(deck)
