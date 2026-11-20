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
	
func update_slots() -> void:
	var index: int = 0
	for slot in container.get_children():
		if inventory_items[index] != null:
			slot.icon = inventory_items[index].icon
		else:
			slot.icon = null
			
		index += 1

# returns whether the item could be added or not
func add_item(new_item: Item) -> bool:
	for index in max_index:
		print(index)
		if inventory_items[index] == null:
			inventory_items[index] = new_item
			update_slots()
			return true
		
	return false
	
func remove_item(item_to_remove: Item) -> bool:
	return true
	
