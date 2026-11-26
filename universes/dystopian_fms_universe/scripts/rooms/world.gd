extends Node

@export var player: CharacterBody2D
@export var camera: Camera2D
@export var buddy: Node2D

#func _ready() -> void:
	#player = get_node("Player")
	#camera = get_node("Camera2D")
	#buddy = get_node("CameraHelper")
