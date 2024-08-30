extends CardEffect
class_name ChristmasEffect

func execute(entity_manager: EntityManager) -> bool:
	entity_manager.resource_utils.try_fulfill(CityResource.new(0, -20, 0, -20))
	var res = entity_manager.resource_utils.resource
	var pop_bonus: int = - int(res.population * 0.1)
	entity_manager.resource_utils.try_fulfill(CityResource.new(pop_bonus, 0, 0, 0))
	return true
