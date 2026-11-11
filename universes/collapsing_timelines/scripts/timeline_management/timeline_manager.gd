extends Node
class_name TimelineManager

enum TimelineState { Past, Present }

signal timeline_changed(new_timeline_state: TimelineState)

@export var present_timeline_root: Node
@export var past_timeline_root: Node

var current_timeline: TimelineState = TimelineState.Present:
	get = get_current_timeline,
	set = set_new_timeline

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("swap_timeline")):
		set_new_timeline(get_opposite_timeline(current_timeline))
	
func get_current_timeline() -> TimelineState:
	return current_timeline
	
func set_new_timeline(new_timeline: TimelineState) -> void:
	current_timeline = new_timeline
	timeline_changed.emit(new_timeline)

func past_world_to_present_world(past_world_pos: Vector2) -> Vector2:
	return (past_world_pos - past_timeline_root.global_position) + present_timeline_root.global_position

func present_world_to_past_world(present_world_pos: Vector2) -> Vector2:
	return (present_world_pos - present_timeline_root.global_position) + past_timeline_root.global_position

func get_pos_in_other_timeline(current_world_pos: Vector2, user_current_timeline: TimelineState) -> Vector2:
	match user_current_timeline:
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
			
	return 0 as TimelineState
