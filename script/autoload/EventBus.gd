extends Node

# Trạng thái game
signal game_start_event
signal game_won_event
signal game_lose_event
signal pause_event(is_paused : bool)

# Game resource change
signal money_changed(new_amount : int)
signal citizen_changed(new_amount : int)
