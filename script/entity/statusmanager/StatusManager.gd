extends Node
class_name StatusManager

#enum Status {HEALTH_LOW, MOOD_LOW, MONEY_LOW}

var entity_manager : EntityManager

func _ready() -> void:
	await get_parent().ready
	entity_manager = get_parent()

# PROLLY SHOULD REFACTOR LATER BUT DAMN ARE WE LATE FOR THAT
func get_penalty() -> CityResource:
	var original: CityResource = entity_manager.resource_utils.resource
	var penalty: CityResource = CityResource.new(0, 0, 0, 0)
	
	# HEALTH STATUSES
	if original.health <= 10:
		penalty.population += int(original.population * 0.9)
	if 11 <= original.health and original.health <= 60:
		if _random_prob(0.2):
			penalty.population += 1
	if 61 <= original.health and original.health <= 80:
		if _random_prob(0.2):
			penalty.population -= int(original.population * 0.05)
	if 81 <= original.health:
		if _random_prob(0.6):
			penalty.population -= ceili(original.population * 0.1)
	
	# MONEY STATUSES
	if original.money <= 10:
		penalty.mood += 50
		penalty.health += 30
	if 11 <= original.money and original.money <= 40:
		if _random_prob(0.2):
			penalty.mood += 5
	if 60 <= original.money and original.money <= 80:
		if _random_prob(0.5):
			penalty.mood -= 5
	if 81 <= original.money:
		penalty.mood -= 5
			
	return penalty


func get_multiplier() -> float:
	var original: CityResource = entity_manager.resource_utils.resource
	var multi: float
	# HAPI NESS HAPI HAPI HAPPI
	if original.mood <= 10:
		multi = 0
	if 11 <= original.money and original.money <= 40:
		multi = 0.75
	if 41 <= original.money and original.money < 80:
		multi = 1
	if 81 <= original.money:
		multi = 1.5
	return multi


func _random_prob(probability: float) -> bool:
	return probability < randf()
