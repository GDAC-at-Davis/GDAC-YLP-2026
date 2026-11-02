extends Node
class_name TimelineManager

signal timeline_changed(now_in_past: bool)

var in_past: bool = false: 
	set = set_in_past, 
	get = get_in_past

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("swap_timeline")):
		set_in_past(not in_past)
	
func get_in_past() -> bool:
	return in_past
	
func set_in_past(new_in_past: bool) -> void:
	in_past = new_in_past
	timeline_changed.emit(in_past)
