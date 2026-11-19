class_name Item
extends Resource

enum ItemType {
	GOLD_KEY,
	SILVER_KEY,
	JADE_KEY
}

var type: ItemType
var icon: Texture2D

func _init(p_type: ItemType, p_icon: Texture2D) -> void:
	type = p_type
	icon = p_icon
