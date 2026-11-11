extends MovementManager
class_name FollowInputManager

const TimelineState = TimelineManager.TimelineState

@export var managed_player: PossessableCharacter
@export var target_player: PossessableCharacter
@export var timeline_manager: TimelineManager
@export var timeline_state: TimelineState

func update_movement(_delta: float) -> void:
	if (managed_player._is_possessed): return
	
	var opposite_state: TimelineState = timeline_manager.get_opposite_timeline(timeline_state)
	managed_player.global_position = timeline_manager.get_pos_in_other_timeline(target_player.global_position, opposite_state)
	
