extends Node
class_name DFMSGameManager

## Dystopian Face Mask Society Game Manager
##
## Overarching game manager to deal with inter-object communication
## like changing game state.


enum PlayerControlState {
	NO_CTRL,
	PLAYER,
	INTERACTABLE_SELECT,
}


var player: CharacterBody2D
var camera: Camera2D
var buddy: Node

var _player_control_state: PlayerControlState = PlayerControlState.PLAYER


func _ready() -> void:
	pass
	#var room = get_node_or_null("/root/Room")
	#if not room: return
	#player = room.get_node_or_null("Test Player")
	#camera = room.get_node_or_null("Test Camera2D")
	#buddy = room.get_node_or_null("Test CameraHelper")


func request_change_active_camera(new_cam: Camera2D):
	pass


func change_player_control_state(new_state: PlayerControlState):
	pass
