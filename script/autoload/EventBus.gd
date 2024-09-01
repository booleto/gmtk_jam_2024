extends Node

# Trạng thái game
signal game_start_event
signal game_won_event
signal game_lose_event
signal pause_event(is_paused : bool)
signal turn_end_event(turn : int)

# Game resource change
signal money_changed(new_amount : int)
signal citizen_number_changed(new_amount : int)
signal citizen_health_changed(new_amount : int)
signal citizen_mood_changed(new_amount : int)
signal energy_changed(new_amount : int)

# Insufficient resources
signal not_enough_resources
signal not_enough_energy
signal not_valid_building_placement

signal card_play_event(card: Card)
signal card_setup_event(hand: Array[Card])

signal ui_play_card(card: Card)


enum SignalIndex {
    GAME_START, GAME_WON, GAME_LOSE, PAUSE, TURN_END,
    MONEY, POPULATION, HEALTH, MOOD, ENERGY,
    INSUFFICIENT_RESOURCES, INSUFFICIENT_ENERGY, INVALID_PLACEMENT,
    CARD_PLAY, CARD_SETUP, UI_PLAY_CARD
}

var signal_map : Dictionary = {
    SignalIndex.GAME_START : game_start_event,
    SignalIndex.GAME_WON : game_won_event,
    SignalIndex.GAME_LOSE : game_lose_event,
    SignalIndex.PAUSE : pause_event,
    SignalIndex.TURN_END : turn_end_event,
    SignalIndex.MONEY : money_changed,
    SignalIndex.POPULATION : citizen_number_changed,
    SignalIndex.HEALTH : citizen_health_changed,
    SignalIndex.MOOD : citizen_mood_changed,
    SignalIndex.ENERGY : energy_changed,
    SignalIndex.INSUFFICIENT_RESOURCES : not_enough_resources,
    SignalIndex.INSUFFICIENT_ENERGY : not_enough_energy,
    SignalIndex.INVALID_PLACEMENT : not_valid_building_placement,
    SignalIndex.CARD_PLAY : card_play_event,
    SignalIndex.CARD_SETUP : card_setup_event,
    SignalIndex.UI_PLAY_CARD : ui_play_card,
}