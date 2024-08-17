extends Resource

class_name CityResource

@export var intellect: int
@export var population: int
@export var mood: int
@export var health: int
@export var money: int

func _init(intellect = 0, population = 0, mood = 100, health = 100, money = 999) -> void:
	self.intellect = intellect
	self.population = population
	self.mood = mood
	self.health = health
	self.money = money

func apply(request: CityResource):
	self.intellect += request.intellect
	self.population += request.population
	self.mood += request.mood
	self.health += request.health
	self.money += request.money
