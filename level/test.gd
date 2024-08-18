@tool
extends Node

enum types { SKILL, ITEM, EQUIPMENT }

func _get_property_list():
	var property_list = []
	property_list.append({
		"name": "hammer_type",
		"type": TYPE_STRING,
		"usage": PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_STORAGE, 
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(types.keys())
	})
	return property_list
