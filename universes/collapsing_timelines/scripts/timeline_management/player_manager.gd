extends Node
class_name PlayerManager

@export var timeline_manager: TimelineManager
@export var current_character: PossessableCharacter
@export var past_character: PossessableCharacter

func _physics_process(delta: float) -> void:
	var used_character = get_current_player()
	
	if Input.is_action_just_pressed("jump"):
		used_character.handle_jump()
	
	var direction = Input.get_axis("left", "right")
	used_character.handle_movement(direction)

func get_current_player() -> PossessableCharacter:
		return past_character if timeline_manager.in_past else current_character

func get_inactive_player() -> PossessableCharacter:
		return current_character if timeline_manager.in_past else past_character

# Connected via Godot signal manager
func _on_timeline_manager_timeline_changed(now_in_past: bool) -> void:
	# Fix movement not stopping after swapping timelines when
	# holding input direction
	get_inactive_player().handle_movement(0)
