extends BuildingEffect
class_name MarketEffect

func calc_bonus(adjacent_builds : Array[Building], args : Dictionary) -> CityResource:
	var turn = args["turn"]
	
	var resource = CityResource.new(0, 0, 0, -10)
	return resource
