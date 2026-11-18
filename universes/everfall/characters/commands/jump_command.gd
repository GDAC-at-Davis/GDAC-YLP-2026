class_name JumpCommand
extends Command


func execute(character: Character) -> Status:
	var input = character.jump_velocity
	
	if character.is_on_floor():
		character.velocity.y = input
	elif character.double_jump:
		character.velocity.y = input
		character.double_jump = false
	
	return Status.DONE
