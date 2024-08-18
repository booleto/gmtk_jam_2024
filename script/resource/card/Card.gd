extends Resource
class_name Card

enum CardType {BUILD, EFFECT}

@export var card_name : String
@export var energy_cost : int
@export var ui_scene : PackedScene
@export var type : CardType
@export var effect : CardEffect
