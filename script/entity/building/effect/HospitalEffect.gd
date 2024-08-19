extends BuildingEffect
class_name HospitalEffect


func calc_bonus(adjacent_builds : Array[Building], args : Dictionary) -> CityResource:
	var turn = args["turn"]
	
	var adj_house_count = nearby_building(adjacent_builds, "house")
	var resource = CityResource.new(0, 0, 0, 0)
	return resource
