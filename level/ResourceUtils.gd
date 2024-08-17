extends Node

@export var build_utils : BuildUtils
var resource: CityResource

# Connect building turn end signals to handler function
func _ready() -> void:
	await get_parent().ready
	build_utils.building_built.connect(_on_new_building)

## Change the population by an amount (positive or negative)
## Warning: this can make the population went negative
func change_population_by(amount: int):
	resource.population += amount

## Internal use, don't use it or perish
func _resource_as_array(res: CityResource) -> PackedInt32Array:
	return [res.intellect, res.population, res.mood, res.health, res.money]


## Pass a CityResource and return a bool whether it is able to fulfill the request
func able_to_fulfill(request: CityResource) -> bool:
	var res_arr = _resource_as_array(resource)
	var req_arr = _resource_as_array(request)
	for i in range(res_arr):
		if res_arr[i] - req_arr[i] < 0:
			return false

	return true


func try_fulfill(request: CityResource) -> bool:
	if able_to_fulfill(request) == true:
		resource.apply(request)
		return true
	else:
		return false


func _on_new_building(building : Building):
	building.apply_effect.connect(_on_building_effect)
	print("connected to building: ", building)
	

func _on_building_effect(effect : BuildingEffect):
	prints("new turn effect: ", effect)
	pass
