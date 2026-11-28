extends Node
class_name DFMSGameManager

## Dystopian Face Mask Society Game Manager
##
## Overarching game manager to deal with inter-object communication
## like changing game state.


enum GameState {
	ACTIVE,
	SELECTION,
	DIALOGUE,
	PAUSED,
}


signal request_change_active_camera(cam: Camera2D)
signal request_disengage_camera(cam: Camera2D)
signal enter_selection_mode(player_position: Vector2)
signal exit_selection_mode
signal enter_player_active_mode
signal exit_player_active_mode
signal enter_paused_mode
signal exit_paused_mode
signal enter_dialogue_mode
signal exit_dialogue_mode


# Game pausing to be worked on
var _game_paused: bool

var player: CharacterBody2D
var buddy: Node

var _current_state: GameState = GameState.PAUSED

## Maintains a queue for cameras so that cameras don't have to fight
## over priority.
var _camera_queue: Array[Camera2D] = []
var active_camera: Camera2D = null


func _ready() -> void:
	set_game_state(GameState.ACTIVE)
	pass
	#var room = get_node_or_null("/root/Room")
	#if not room: return
	#player = room.get_node_or_null("Test Player")
	#camera = room.get_node_or_null("Test Camera2D")
	#buddy = room.get_node_or_null("Test CameraHelper")


func get_game_state():
	return _current_state


func is_in_selection_mode():
	return _current_state == GameState.SELECTION


func is_in_player_active_mode():
	return _current_state == GameState.ACTIVE


func is_in_dialogue_mode():
	return _current_state == GameState.DIALOGUE


func is_in_paused_mode():
	return _current_state == GameState.PAUSED


func set_game_state(new_state: GameState):
	if new_state != _current_state:
		match _current_state:
			GameState.ACTIVE:
				exit_player_active_mode.emit()
			GameState.SELECTION:
				exit_selection_mode.emit()
			GameState.DIALOGUE:
				exit_dialogue_mode.emit()
			GameState.PAUSED:
				exit_paused_mode.emit()
	match new_state:
		GameState.ACTIVE:
			enter_player_active_mode.emit()
		GameState.SELECTION:
			enter_selection_mode.emit(player.global_position)
		GameState.DIALOGUE:
			enter_dialogue_mode.emit()
		GameState.PAUSED:
			enter_paused_mode.emit()
	_current_state = new_state


func _update_camera_queue():
	for cam in _camera_queue:
		cam.enabled = false
	if not _camera_queue.is_empty():
		active_camera = _camera_queue.front()
		active_camera.enabled = true


func _on_request_change_active_camera(new_cam: Camera2D):
	_camera_queue.push_front(new_cam)
	_update_camera_queue()


func _on_request_disengage_active_camera(cam: Camera2D):
	if _camera_queue.has(cam):
		_camera_queue.erase(cam)
		_update_camera_queue()
	else:
		push_warning("DFMSGameManager tried to disengage camera not in queue.")
