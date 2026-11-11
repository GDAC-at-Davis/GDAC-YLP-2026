extends Node
class_name PossessedPlayerManager

@export var timeline_manager: TimelineManager
@export var present_character: PossessableCharacter
@export var past_character: PossessableCharacter

func get_current_player() -> PossessableCharacter:
	match timeline_manager.current_timeline:
		TimelineManager.TimelineState.Present:
			return present_character
		TimelineManager.TimelineState.Past:
			return past_character
	return null

func get_inactive_player() -> PossessableCharacter:
	match timeline_manager.current_timeline:
		TimelineManager.TimelineState.Past:
			return present_character
		TimelineManager.TimelineState.Present:
			return past_character
	return null

# Connected via Godot signal manager
func _on_timeline_manager_timeline_changed(_now_in_past: bool) -> void:
	get_inactive_player().set_possessed(false)
	get_current_player().set_possessed(true)
