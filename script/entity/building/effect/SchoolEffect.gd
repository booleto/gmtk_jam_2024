extends BuildingEffect
class_name SchoolEffect

func calc_bonus(adjacent_builds : Array[Building], args : Dictionary) -> CityResource:
	var turn = args["turn"]
	
	var resource = CityResource.new(0, -5, 0, 0)
	return resource
