extends BuildingEffect
class_name CompanyEffect

func calc_bonus(adjacent_builds : Array[Building], args : Dictionary) -> CityResource:
	var turn = args["turn"]
	
	var resource = CityResource.new()
	return resource
