class_name Item
extends Resource

enum ItemType {
	GOLD_KEY,
	SILVER_KEY,
	JADE_KEY,
	CARROT,
	GARLIC,
	MUSHROOM,
}

@export var type: ItemType
@export var icon: Texture2D
