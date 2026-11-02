extends Camera2D

var follow_speed: float = 4.0
var zoom_speed: float = 12.0

# This should be the World node
var world: Node

func _ready() -> void:
	world = get_tree().root.get_node("World");

func _physics_process(delta: float) -> void:
	if world.camera_helper:
		global_position = lerp(global_position, world.camera_helper.global_position, follow_speed * delta)
		zoom = lerp(zoom, world.camera_helper.zoom, zoom_speed * delta)
