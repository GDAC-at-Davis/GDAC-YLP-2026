extends State

@export var move_state: State
@export var jump_state: State
@export var player: CharacterBody2D

func enter_state() -> void:
	# Change to idle sprite (wait don't)
	player.velocity.x = 0

func exit_state() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	# When any direction is inputted, change to move state
	if Input.get_vector("left", "right", "up", "down") != Vector2.ZERO:
		switch_state.emit(move_state)
	
	if Input.is_action_just_pressed("a") and player.is_on_floor():
		switch_state.emit(jump_state)
