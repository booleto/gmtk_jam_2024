extends Node

var resource: CityResource

## Change the population by an amount (positive or negative)
## Warning: this can make the population went negative
func change_population_by(amount: int):
	resource.population += amount

## Internal use, don't use it or perish
func _resource_as_array(res: CityResource) -> PackedInt32Array:
	return [res.intellect, res.population, res.mood, res.health, res.money]

## Pass a CityResource and return a bool whether it is able to fulfill the request
## If it returns true, the actual resource will be subtracted
func try_request_resources(request: CityResource) -> bool:
	var res_arr = _resource_as_array(resource)
	var req_arr = _resource_as_array(request)
	for i in range(res_arr):
		if res_arr[i] - req_arr[i] < 0:
			return false

	for i in range(res_arr):
		res_arr[i] -= req_arr[i]
	return true
