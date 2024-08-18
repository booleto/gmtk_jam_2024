extends Resource

class_name CityResource

@export var population: int
@export var mood: int
@export var health: int
@export var money: int

func _init(p_population := 0, p_mood := 100, p_health := 100, p_money := 999) -> void:
	self.population = p_population
	self.mood = p_mood
	self.health = p_health
	self.money = p_money
