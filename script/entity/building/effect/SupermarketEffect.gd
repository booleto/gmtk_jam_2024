extends BuildingEffect
class_name SupermarketEffect

func calc_bonus(adjacent_builds : Array[Building], args : Dictionary) -> CityResource:
	var turn = args["turn"]
	
	var resource = CityResource.new(0, 0, 0, 0)
	return resource
