extends BuildingEffect
class_name PubEffect

#var resource : CityResource
var multi = 0.2

func calc_bonus(adjacent_builds : Array[Building], args : Dictionary) -> CityResource:
	var bonus = CityResource.new(0, 0, 0, 0)
	for build in adjacent_builds:
		var build_bonus = build.building_effect.calc_bonus([], args)
		bonus.health -= ceil(build_bonus.health * multi)
		bonus.money -= ceil(build_bonus.money * multi)
		bonus.mood -= ceil(build_bonus.mood * multi)
		bonus.population -= ceil(build_bonus.population * multi)
	bonus.money += 5
	return bonus
