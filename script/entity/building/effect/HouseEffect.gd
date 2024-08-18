extends BuildingEffect
class_name HouseEffect

func calc_bonus(adjacent_builds : Array[Building], args : Dictionary) -> CityResource:
	var turn : int = args["turn"]
	
	var resource = CityResource.new(0, -2, 0, 0, 0) if turn % 2 == 1 else CityResource.new(0, 0, 0, 0, 0)
	return resource
