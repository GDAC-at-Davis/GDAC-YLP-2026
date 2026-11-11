extends CameraMode
class_name FollowPlayerMode

var target_player: PossessableCharacter
var player_offset: Vector2

func get_camera_target() -> Vector2:
	return target_player.global_position + player_offset
