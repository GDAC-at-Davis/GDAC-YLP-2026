extends Camera2D
class_name TimelinesCamera

@export var timeline_manager: TimelineManager
@export var position_lerp_speed: float = 4.0
@export var zoom_speed: float = 12.0

var active_modes: Dictionary[CameraArea, CameraMode]

func _ready() -> void:
	timeline_manager.timeline_changed.connect()

func _physics_process(delta: float) -> void:
	if (active_modes.is_empty()): return
	
	var target_pos: Vector2 = active_modes.values()[0].get_camera_target()
	var target_zoom: Vector2 = active_modes.values()[0].get_camera_zoom()
	global_position = lerp(global_position, target_pos, position_lerp_speed * delta)
	zoom = lerp(zoom, target_zoom, zoom_speed * delta)
	
func register_camera_mode(mode_owner: CameraArea, mode: CameraMode) -> void:
	if (active_modes.has(mode_owner)): return
	
	active_modes.get_or_add(mode_owner, mode)
	sort_camera_modes()

func remove_camera_mode(mode_owner: Object) -> void:
	active_modes.erase(mode_owner)
	sort_camera_modes()
	
func sort_camera_modes() -> void:
	var keys: Array[CameraArea] = active_modes.keys()
	keys.sort_custom(func(x: CameraArea, y: CameraArea) -> bool: return active_modes[x].priority > active_modes[y].priority)
	var new_dict: Dictionary[CameraArea, CameraMode]
	
	for key in keys:
		new_dict.get_or_add(key, active_modes[key])
	
	active_modes = new_dict

func on_timeline_changed()
