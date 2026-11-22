@tool

extends DialogueActionable2D

@export var repeatable : bool = false

var player : CharacterBody2D
var can_interact : bool = true

func _on_body_entered(body: CharacterBody2D) -> void:
	if not can_interact: return
	if body.is_in_group("player"):
		player = body
		%Indicator.visible = true

func _physics_process(_delta: float) -> void:
	if not can_interact: return
	if player:
		if Input.is_action_just_pressed("c") and not player.in_dialogue:
			player.in_dialogue = true
			player.movement_stasis = true
			action()

func _on_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		player = null
		%Indicator.visible = false

func _on_actioned() -> void:
	%Indicator.visible = false

func _on_dialogue_ended(ending_dialogue_resource: DialogueResource) -> void:
	if ending_dialogue_resource == dialogue_resource:
		if player:
			player.in_dialogue = false
			player.movement_stasis = false
			player = null
			%Indicator.visible = false
		if not repeatable:
			can_interact = false
