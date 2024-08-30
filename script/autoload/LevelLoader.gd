extends Node

var LEVEL : PackedScene = load("res://level/demo_level.tscn")
var WIN : PackedScene = load("res://scene/UI/victory_screen.tscn")
var MAIN_MENU : PackedScene = load("res://scene/UI/main_menu.tscn")
var CREDITS : PackedScene

var current_level: int = 0
var current_quota: int = 80

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


func reload():
	load_scene(LEVEL)
	
func level_up():
	current_level += 1
	current_quota += 20
	for i in range(2):
		var idx: int = randi_range(0, current_deck.size() - 1)
		var incr_card: Card = current_deck.keys()[idx]
		current_deck[incr_card] += 1
		prints("updated deck size with card: ", incr_card.card_name)
	
	load_scene(LEVEL)

func load_scene(level):
	get_tree().change_scene_to_packed(level)
	await get_tree().root.ready
