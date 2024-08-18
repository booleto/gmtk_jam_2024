extends Resource
class_name BuildingEffect

var resource : CityResource

func calc_bonus(adjacent_builds : Array[Building], args : Dictionary) -> CityResource:
	return null

func nearby_building(adj: Array[Building], building_name: String) -> int:
	var adj_count = len(adj.filter(
		func(b : Building):
			return b.building_data.building_name == building_name
	))
	return adj_count
	
