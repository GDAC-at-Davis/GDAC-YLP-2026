class_name Inventory
extends Control

var max_index: int
var selected_index: int = 0
var inventory_items: Array[Item]

@onready var container: HBoxContainer = $NinePatchRect/HBoxContainer


func _ready() -> void:
	max_index = container.get_child_count() - 1
	
	for slot in container.get_children():
		slot.icon = null
		slot.connect("pressed", slot_selected)
		inventory_items.append(null)
		
	
	
func slot_selected() -> void:
	print("click")
