extends Node
class_name ResourceUtils

@export var build_utils : BuildUtils
@export var resource: CityResource

# Connect building turn end signals to handler function
func _ready() -> void:
	await get_parent().ready
	build_utils.building_built.connect(_on_new_building)
	EventBus.citizen_number_changed.emit(resource.population)
	EventBus.citizen_mood_changed.emit(resource.mood)
	EventBus.citizen_health_changed.emit(resource.health)
	EventBus.money_changed.emit(resource.money)


## Change the population by an amount (positive or negative)
## Warning: this can make the population went negative
func change_population_by(amount: int):
	resource.population += amount

## Internal use, don't use it or perish
func _resource_as_array(res: CityResource) -> PackedInt32Array:
	return [res.population, res.mood, res.health, res.money]


## Pass a CityResource and return a bool whether it is able to fulfill the request
func able_to_fulfill(request: CityResource) -> bool:
	var res_arr = _resource_as_array(resource)
	var req_arr = _resource_as_array(request)
	for i in range(len(res_arr)):
		if res_arr[i] - req_arr[i] < 0:
			return false

	return true


func try_fulfill(request: CityResource) -> bool:
	if not able_to_fulfill(request):
		return false
	
	resource.population -= request.population
	resource.mood -= request.mood
	resource.health -= request.health
	resource.money -= request.money
	
	if request.population != 0:
		EventBus.citizen_number_changed.emit(resource.population)
		print("population changed: ", resource.population)
	if request.mood != 0:
		EventBus.citizen_mood_changed.emit(resource.mood)
		print("mood changed: ", resource.mood)
	if request.health != 0:
		EventBus.citizen_health_changed.emit(resource.health)
		print("health changed: ", resource.health)
	if request.money != 0:
		EventBus.money_changed.emit(resource.money)
		print("money changed: ", resource.money)
		
	return true


func _on_new_building(building : Building):
	building.apply_effect.connect(_on_building_effect)
	

func _on_building_effect(effect : BuildingEffect, adjs : Array[Building]):
	#prints("new turn effect: ", effect)
	prints("adj builds: ", adjs.map(func(b : Building) -> String: return b.building_name))
	var changes : CityResource = effect.calc_bonus(adjs, {"turn" : get_parent().turn})
	try_fulfill(changes)
	pass
