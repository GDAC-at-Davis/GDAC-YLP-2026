extends Node
class_name DFMSGameManager

## Dystopian Face Mask Society Game Manager
##
## Overarching game manager to deal with inter-object communication
## like changing game state.


enum GameState {
	ACTIVE,
	SELECTING,
	DIALOGUE,
}

# Game pausing to be worked on
var _game_paused: bool

var player: CharacterBody2D
var camera: Camera2D
var buddy: Node

var _current_state: GameState


func _ready() -> void:
	pass
	#var room = get_node_or_null("/root/Room")
	#if not room: return
	#player = room.get_node_or_null("Test Player")
	#camera = room.get_node_or_null("Test Camera2D")
	#buddy = room.get_node_or_null("Test CameraHelper")


func request_change_active_camera(new_cam: Camera2D):
	pass


func get_game_state():
	return _current_state


func set_game_state(new_state: GameState):
	pass
