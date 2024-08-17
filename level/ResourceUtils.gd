extends Node

var resource: CityResource

## Change the population by an amount (positive or negative)
## Warning: this can make the population went negative
#func change_population_by(amount: int):
	#resource.population += amount

## Internal use, don't use it or perish
func _resource_as_array(res: CityResource) -> PackedInt32Array:
	return [res.intellect, res.population, res.mood, res.health, res.money]

## Pass a CityResource and return a bool whether it is able to fulfill the request
func able_to_fulfill(request: CityResource) -> bool:
	var res_arr = _resource_as_array(resource)
	var req_arr = _resource_as_array(request)
	for i in len(res_arr):
		if res_arr[i] - req_arr[i] < 0:
			return false

	return true

func fulfill(request: CityResource) -> bool:
	if able_to_fulfill(request) == true:
		resource.fulfill(request)
		return true
	else:
		return false
