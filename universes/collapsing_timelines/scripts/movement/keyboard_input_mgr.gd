extends MovementManager
class_name KeyboardInputManager

@export var player_manager: PossessedPlayerManager

func update_movement(_delta: float) -> void:
	var used_character = player_manager.get_current_player()
	
	if Input.is_action_just_pressed("jump"):
		used_character.handle_jump()
	
	var direction = Input.get_axis("left", "right")
	used_character.handle_movement(direction)

# Connected via Godot signal manager
func _on_timeline_manager_timeline_changed(_now_in_past: bool) -> void:
	# Fix movement not stopping after swapping timelines when
	# holding input direction
	player_manager.get_inactive_player().handle_movement(0)
