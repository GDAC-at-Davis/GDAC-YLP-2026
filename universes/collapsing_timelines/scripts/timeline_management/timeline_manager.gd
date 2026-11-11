extends Node
class_name TimelineManager

enum TimelineState { Past, Present }

signal timeline_changed(now_in_past: bool)

@export var present_timeline_root: Node
@export var past_timeline_root: Node

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

func past_world_to_present_world(past_world_pos: Vector2) -> Vector2:
	return (past_world_pos - past_timeline_root.global_position) + present_timeline_root.global_position

func present_world_to_past_world(present_world_pos: Vector2) -> Vector2:
	return (present_world_pos - present_timeline_root.global_position) + past_timeline_root.global_position

func get_pos_in_other_timeline(current_world_pos: Vector2, current_timeline: TimelineState) -> Vector2:
	match current_timeline:
		TimelineState.Past:
			return past_world_to_present_world(current_world_pos)
		TimelineState.Present:
			return present_world_to_past_world(current_world_pos)
	
	return Vector2.ZERO

func get_opposite_timeline(timeline: TimelineState) -> TimelineState:
	match timeline:
		TimelineState.Past:
			return TimelineState.Present
		TimelineState.Present:
			return TimelineState.Past
			
	return 0
