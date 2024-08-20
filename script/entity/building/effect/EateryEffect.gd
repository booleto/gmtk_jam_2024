extends BuildingEffect
class_name EateryEffect

#var resource : CityResource

func calc_bonus(adjacent_builds : Array[Building], args : Dictionary) -> CityResource:
	return CityResource.new(0, 0, 0, 0)
