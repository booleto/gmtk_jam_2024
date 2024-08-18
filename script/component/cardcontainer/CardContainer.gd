extends HBoxContainer

var card_ui: PackedScene = preload("res://scene/UI/card/CardUI.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.card_setup_event.connect(_on_hand_update)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hand_update(hand: Array[Card]):
	for i in range(len(hand)):
		var card_node: CardUI = get_child(i)
		card_node.load_card_data(hand[i])


func _on_hand_init(hand: Array[Card]):
	for card in hand:
		var card_node: CardUI = card_ui.instantiate()
		card_node.card = card
		add_child(card_node)
