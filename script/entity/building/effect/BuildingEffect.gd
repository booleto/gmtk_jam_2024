extends Resource
class_name BuildingEffect

var request: CityResource

func apply_effects(resource, args):
	assert(resource.fulfill(request))
