extends Node

@export var player: CharacterBody2D
@export var camera: Camera2D
@export var buddy: Node2D

func _ready() -> void:
	TestGameManager.player = player if player else null
	TestGameManager.camera = camera if camera else null
	TestGameManager.buddy = buddy if buddy else null
