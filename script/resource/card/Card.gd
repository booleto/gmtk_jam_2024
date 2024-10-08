extends Resource
class_name Card

enum CardType {BUILD, EFFECT}
enum CardFrame {HOUSE, HOSPITAL, MARKET, SUPERMARKET, SCHOOL, COMPANY, EATERY, BAR, PUB, LOCAL_FEST, CHRISTMAS, ONE_MORE_CHANCE}

@export var card_name : String
@export var energy_cost : int
@export var ui_scene : PackedScene
@export var type : CardType
@export var effect : CardEffect
#@export var cost: int
@export var discard : bool

@export var frame : CardFrame
@export_multiline var tooltip : String
