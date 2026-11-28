@tool

extends DialogueActionable2D

@export var repeatable : bool = false

var player : CharacterBody2D
var has_run = false

func _on_body_entered(body: CharacterBody2D) -> void:
	if has_run:
		return
	if not (is_instance_valid(dialogue_resource) and not dialogue_cue.is_empty()):
		return
	if not body.is_in_group("player"):
		return

	player = body
	player.in_dialogue = true
	player.movement_stasis = true
	has_run = true
	action()

func _on_actioned() -> void:
	pass

func _on_dialogue_ended(ending_dialogue_resource: DialogueResource) -> void:
	if not has_run:
		return
	if ending_dialogue_resource != dialogue_resource:
		return

	if player:
		player.in_dialogue = false
		player.movement_stasis = false
		player = null

	if not repeatable:
		queue_free()
