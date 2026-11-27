# Transition area script, attach this to an Area2D to make it change scenes when entered

extends Area2D

# Must be a UID (right click -> copy path as UID)
@export var scene_to_load : StringName = &""

# Can accidentally occur if a CharacterBody2D node other than the player
# enteres the Area2D, so we use identifiers like groups or names to help specify
func _on_body_entered(_body: CharacterBody2D) -> void:
	if _body.is_in_group("player"): # make sure the player in your level is in the "player" group!
		TestSceneLoader.load_scene(scene_to_load)
