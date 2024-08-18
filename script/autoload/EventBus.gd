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
signal citizen_iq_changed(new_amount : int)
signal citizen_health_changed(new_amount : int)
signal citizen_mood_changed(new_amount : int)

signal card_changed()
