extends Node
class_name PossessedPlayerManager

@export var timeline_manager: TimelineManager
@export var current_character: PossessableCharacter
@export var past_character: PossessableCharacter

func get_current_player() -> PossessableCharacter:
		return past_character if timeline_manager.in_past else current_character

func get_inactive_player() -> PossessableCharacter:
		return current_character if timeline_manager.in_past else past_character

# Connected via Godot signal manager
func _on_timeline_manager_timeline_changed(_now_in_past: bool) -> void:
	get_inactive_player().set_possessed(false)
	get_current_player().set_possessed(true)
