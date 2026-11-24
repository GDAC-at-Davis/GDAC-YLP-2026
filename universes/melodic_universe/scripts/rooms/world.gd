extends Node

@export var player: CharacterBody2D
@export var camera: Camera2D
@export var buddy: Node2D
@export var metronome: Node2D

func _ready() -> void:
	MelodicGameManager.player = player if player else null
	MelodicGameManager.camera = camera if camera else null
	MelodicGameManager.buddy = buddy if buddy else null
	MelodicGameManager.metronome = metronome if metronome else null
	#player = get_node("Player")
	#camera = get_node("Camera2D")
	#buddy = get_node("CameraHelper")
