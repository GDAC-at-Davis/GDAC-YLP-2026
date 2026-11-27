@tool

extends DialogueActionable2D

@export var repeatable : bool = false

var player : CharacterBody2D

func _on_body_entered(body: CharacterBody2D) -> void:
	print("entered")
	if is_instance_valid(dialogue_resource) and not dialogue_cue.is_empty():
		if body.is_in_group("player"):
			player = body
			player.in_dialogue = true
			player.movement_stasis = true
			action()

func _on_actioned() -> void:
	pass

func _on_dialogue_ended(ending_dialogue_resource: DialogueResource) -> void:
	if ending_dialogue_resource == dialogue_resource:
		if player:
			player.in_dialogue = false
			player.movement_stasis = false
		if not repeatable:
			queue_free()
