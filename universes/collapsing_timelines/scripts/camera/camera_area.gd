extends Area2D
class_name CameraArea

@export var camera: TimelinesCamera
@export var timeline: TimelineManager.TimelineState
@export var zoom : Vector2 = Vector2(2,2)

func _on_body_entered(body: Node2D) -> void:	
	if not body.is_in_group("player"): return
	on_player_entered(body)
	
func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("player"): return
	on_player_left(body)

func on_player_entered(_player: Node2D) -> void:
	pass
	
func on_player_left(_player: Node2D) -> void:
	pass
