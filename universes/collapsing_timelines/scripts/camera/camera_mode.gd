extends Object
class_name CameraMode

var priority: int
var target_zoom: Vector2 = Vector2(1.5, 1.5)

func get_camera_target() -> Vector2:
	return Vector2.ZERO

func get_camera_zoom() -> Vector2:
	return target_zoom
