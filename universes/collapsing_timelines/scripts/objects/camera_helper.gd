extends Node2D

@export var zoom = Vector2(1, 1)
@export var follow_player: bool = true

# This should be the World node
@export var player_manager: PlayerManager
@export var timeline_manager: TimelineManager
@export var present_camera_triggers: Array[Node]
@export var past_camera_triggers: Array[Node]

func _ready() -> void:
	timeline_manager.timeline_changed.connect(on_timeline_changed)

func set_zoom(new_zoom: Vector2) -> void:
	zoom = new_zoom

func set_follow_player(new_follow_player: bool) -> void:
	follow_player = new_follow_player

func on_timeline_changed(now_in_past: bool) -> void:
	for trigger in present_camera_triggers:
		for child in trigger.get_children():
			if (not (child is CollisionShape2D)): continue
			
			child.set_deferred("disabled", now_in_past)
	for trigger in past_camera_triggers:
		for child in trigger.get_children():
			if (not (child is CollisionShape2D)): continue
			
			child.set_deferred("disabled", !now_in_past)

func _process(_delta: float) -> void:	
	var player = player_manager.get_current_player()
	
	if follow_player:
		global_position.x = player.global_position.x
		global_position.y = player.global_position.y - 10
