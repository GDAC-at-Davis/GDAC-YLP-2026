class_name MoveCommand
extends Command

var _is_move_right: bool

func _init(p_is_move_right: bool = false) -> void:
	_is_move_right = p_is_move_right

func execute(character: Character) -> Status:
	var input = character.movement_speed
	
	if _is_move_right:
		character.velocity.x = input
		character.sprite.flip_h = false
		character.change_facing(Character.Facing.RIGHT)
	else:
		character.velocity.x = -1 * input
		character.sprite.flip_h = true
		character.change_facing(Character.Facing.LEFT)
	
	
	return Status.DONE
