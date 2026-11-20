class_name InteractCommand
extends Command


func execute(character: Character) -> Status:
	character.send_interact()
	return Status.DONE
