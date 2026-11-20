extends Area2D

var available_interactables: Array[Interactable]
var selected_interactable: Interactable

func _process(_delta: float) -> void:
	if (selected_interactable != null) && Input.is_action_just_pressed("jump"):
		selected_interactable.interact()

func _on_area_entered(area: Area2D) -> void:
	if area is not Interactable: return
	
	print("Adding ", area)
	available_interactables.append(area)
	update_selected_interactable()


func _on_area_exited(area: Area2D) -> void:
	if area is not Interactable: return
	
	print("Removing ", area)
	available_interactables.erase(area)
	update_selected_interactable()
	
func update_selected_interactable() -> void:
	selected_interactable = null
	var current_closest_dist: float = 999999;
	
	for interactable in available_interactables:
		var dist: float = (interactable.global_position - global_position).length()
		if dist < current_closest_dist:
			current_closest_dist = dist
			selected_interactable = interactable	
