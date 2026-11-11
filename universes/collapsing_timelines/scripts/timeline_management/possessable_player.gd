extends CharacterBody2D
class_name PossessableCharacter

@export var possessed_by_default: bool = false

var _is_possessed: bool = false

func _ready() -> void:
	_is_possessed = possessed_by_default

func handle_movement(_horizontal_input: float, _force: bool = false) -> void:
	pass

func handle_jump(_force: bool = false) -> void:
	pass

func set_possessed(possessed: bool) -> void:
	_is_possessed = possessed
