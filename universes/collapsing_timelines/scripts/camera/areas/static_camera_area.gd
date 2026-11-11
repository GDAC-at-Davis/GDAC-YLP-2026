extends CameraArea

@export var focus_point: Node2D
@export var mode_priority: int = 10

var static_mode: StaticCameraMode

func _ready() -> void:
	static_mode = StaticCameraMode.new()
	static_mode.camera_focus = focus_point.global_position
	static_mode.priority = mode_priority

func on_player_entered(_player: Node2D) -> void:
	camera.register_camera_mode(self, static_mode)
	
func on_player_left(_player: Node2D) -> void:
	camera.remove_camera_mode(self)
