extends Interactable

class_name InteractableButton

@export var one_time_use: bool

var has_interacted: bool

func interact() -> void:
	if (has_interacted && one_time_use): return
	
	super.interact()
	has_interacted = true
	
	if (one_time_use):
		can_interact = false
