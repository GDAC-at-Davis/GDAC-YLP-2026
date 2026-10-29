extends Area2D

@export var zoom : Vector2 = Vector2(2,2)
@export var camera_follow : bool = false

# This should be the World node
@export var world: Node

func _on_body_entered(body: Node2D) -> void:	
	if not body.is_in_group("player"): return
	world.buddy.set_zoom(zoom)
	world.buddy.set_follow_player(camera_follow)
	if not camera_follow:
		var areas = get_overlapping_areas()
		for area in areas:
			if area.is_in_group("camera point"):
				world.buddy.global_position = area.global_position
