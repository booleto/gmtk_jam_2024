extends CardEffect
class_name BuildEffect

@export var building : BuildingData

func execute(entity_manager: EntityManager) -> bool:
	var result = entity_manager.purchase_new_building(entity_manager.get_global_mouse_position(), building)
	return result
