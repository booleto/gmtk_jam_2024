extends BuildingEffect
class_name CompanyEffect

func calc_bonus(adjacent_builds : Array[Building], args : Dictionary) -> CityResource:
	var turn : int = args["turn"]
	var multi : float = args["multi"]
	
	var resource = CityResource.new(0, -5 * multi, 0, -10 * multi)
	return resource
