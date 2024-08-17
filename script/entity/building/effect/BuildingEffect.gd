extends Resource
class_name BuildingEffect

var request: CityResource

func apply_effects(resource, args):
	assert(resource.able_to_fulfill(request))
	
