@tool
extends Node
class_name CardManager

signal deck_shuffled
signal card_played(card: Card)
signal card_drawn(card: Card)

#@export var deck_starters : PackedInt32Array
@export var hand_limit : int
@export var deck_size : int

var entity_manager : EntityManager

var hand : Array[Card] = []
var discard_pile : Array[Card] = []
var deck : Array[Card] = []

var cards: Dictionary = {}
var card_starters: Dictionary = {}

func _init() -> void:
	for data in DirAccess.get_files_at("res://script/resource/card"):
		if data.ends_with("Card.tres"):
			var card: Card = load("res://script/resource/card/" + data)
			cards[card.card_name] = card

func _ready() -> void:
	if Engine.is_editor_hint():
		notify_property_list_changed()
		return
	#_get_property_list()
	await get_parent().ready
	entity_manager = get_parent()
	initialize_deck()

func _get(property: StringName) -> Variant:
	if property.ends_with("Starters"):
		var name = property.trim_suffix(" Starters")
		return card_starters[name]
	return null

func _set(property: StringName, value: Variant) -> bool:
	if property.ends_with("Starters"):
		var name = property.trim_suffix(" Starters")
		card_starters[name] = value
		return true
	return false

func _get_property_list():
	return cards.keys().map(func (name: String) -> Dictionary:
		return {
			"name": "%s Starters" % name,
			"type": TYPE_INT,
			"usage": PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_STORAGE
		}
	)

func initialize_deck(): # TODO: remove placeholder
	#for i in range(deck_starters[0]):
		#deck.append(DataIndex.CARD_COMPANY)
	#for i in range(deck_starters[1]):
		#deck.append(DataIndex.CARD_HOSPITAL)
	#for i in range(deck_starters[2]):
		#deck.append(DataIndex.CARD_HOUSE)
	#for i in range(deck_starters[3]):
		#deck.append(DataIndex.CARD_MARKET)
	#for i in range(deck_starters[4]):
		#deck.append(DataIndex.CARD_SCHOOL)
	for name in card_starters:
		var card = cards[name]
		var i = card_starters[name]
		for j in range(i):
			deck.append(card)
	
	deck.shuffle()
	fill_hand()
	print_hand()
	
	prints(deck.map(func(c: Card): return c.card_name))


func play_card(index: int, discard: bool = false) -> bool:
	if index < 0 or index >= hand_limit:
		return false
	var result = hand[index].effect.execute(entity_manager)
	if result:
		var played_card: Card = hand.pop_at(index)
		draw_card()
		if not discard:
			discard_pile.append(played_card)
		card_played.emit(played_card)
		
	return result
	
	
func draw_card() -> bool:
	if is_hand_full():
		return false
	if len(deck) == 0:
		deck.append_array(discard_pile)
		shuffle_deck()
		
	var card: Card = deck.pop_back()
	hand.append(card)
	card_drawn.emit(card)
	return true


func shuffle_deck():
	deck.shuffle()
	deck_shuffled.emit()


func fill_hand():
	while not is_hand_full():
		draw_card()
	

func is_hand_full() -> bool:
	return len(hand) >= hand_limit
	

	
func print_hand():
	prints("______________________ CURRENT HAND ______________________")
	prints(hand.map(func(c: Card): return c.card_name))
