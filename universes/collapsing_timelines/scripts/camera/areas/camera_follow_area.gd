extends CameraArea

@export var player_focus_offset: Vector2 = Vector2(0, 10)

var follow_mode: FollowPlayerMode

func _ready() -> void:
	follow_mode = FollowPlayerMode.new()
	follow_mode.player_offset = player_focus_offset

func on_player_entered(player: Node2D) -> void:
	follow_mode.target_player = player
	camera.register_camera_mode(self, follow_mode)
	
func on_player_left(_player: Node2D) -> void:
	follow_mode.target_player = null
	camera.remove_camera_mode(self)
