extends Node2D

@export var zoom = Vector2(1, 1)
@export var follow_player: bool = true

# This should be the World node
@export var world: Node
@export var present_camera_triggers: Array[Node]
@export var past_camera_triggers: Array[Node]

var in_past: bool = false

# func _ready() -> void:
	# set_in_past(false)

func set_zoom(new_zoom: Vector2) -> void:
	zoom = new_zoom

func set_follow_player(new_follow_player: bool) -> void:
	follow_player = new_follow_player

func set_in_past(is_in_past: bool) -> void:
	in_past = is_in_past
	for trigger in present_camera_triggers:
		for child in trigger.get_children():
			if (not (child is CollisionShape2D)): continue
			
			child.set_deferred("disabled", in_past)
	for trigger in past_camera_triggers:
		for child in trigger.get_children():
			if (not (child is CollisionShape2D)): continue
			
			child.set_deferred("disabled", !in_past)

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("swap_timeline")):
		set_in_past(not in_past)
	
	var player = world.pastPlayer if in_past else world.currentPlayer
	
	if not player: return
	
	if follow_player:
		global_position.x = player.global_position.x
		global_position.y = player.global_position.y - 10
