extends Node2D

@export var zoom = Vector2(1, 1)
@export var follow_player: bool = true

# This should be the World node
@export var world: Node

func set_zoom(new_zoom: Vector2) -> void:
	zoom = new_zoom

func set_follow_player(new_follow_player: bool) -> void:
	follow_player = new_follow_player

func _process(_delta: float) -> void:
	if not world.player: return
	if follow_player:
		global_position.x = world.player.global_position.x
		global_position.y = world.player.global_position.y - 10
