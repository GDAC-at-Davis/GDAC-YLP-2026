class_name Pickup
extends Node2D

@export var item: Item

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.texture = item.icon


func _on_interact(caller: Character) -> void:
	caller.emit_signal("AddToInventory", item)
	queue_free()
