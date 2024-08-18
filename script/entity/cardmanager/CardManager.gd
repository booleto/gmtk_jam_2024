extends Node
class_name CardManager

signal deck_shuffled
signal card_played(card: Card)
signal card_drawn(card: Card)
signal card_init(hand : Array[Card])

@export var deck_starters : Array[int]
@export var hand_limit : int
@export var deck_size : int

var entity_manager : EntityManager

var hand : Array[Card] = []
var discard_pile : Array[Card] = []
var deck : Array[Card] = []

func _ready() -> void:
	await get_parent().ready
	entity_manager = get_parent()
	initialize_deck()
	

func initialize_deck(): # TODO: remove placeholder
	for i in range(deck_starters[0]):
		deck.append(DataIndex.CARD_COMPANY)
	for i in range(deck_starters[1]):
		deck.append(DataIndex.CARD_HOSPITAL)
	for i in range(deck_starters[2]):
		deck.append(DataIndex.CARD_HOUSE)
	for i in range(deck_starters[3]):
		deck.append(DataIndex.CARD_MARKET)
	for i in range(deck_starters[4]):
		deck.append(DataIndex.CARD_SCHOOL)
	deck.shuffle()
	fill_hand()
	print_hand()
	card_init.emit(hand)
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
