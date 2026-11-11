extends Node
class_name PossessedPlayerManager

@export var timeline_manager: TimelineManager
@export var current_character: PossessableCharacter
@export var past_character: PossessableCharacter

func get_current_player() -> PossessableCharacter:
		return past_character if timeline_manager.in_past else current_character

func get_inactive_player() -> PossessableCharacter:
		return current_character if timeline_manager.in_past else past_character
