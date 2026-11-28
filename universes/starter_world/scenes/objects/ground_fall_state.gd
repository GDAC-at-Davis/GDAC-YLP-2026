extends State

@export var idle_state: State
@export var move_state: State
@export var jump_state: State
@export var player: CharacterBody2D

func enter_state() -> void:
	# Change to fall sprite
	pass

func exit_state() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	# Move player in the direction of the input multiplied by their movement speed
	get_parent().handle_movement(delta)
	
	# Double Jump
	if Input.is_action_just_pressed("a") and not player.is_on_floor() and not player.double_jumped:
		player.double_jumped = true
		switch_state.emit(jump_state)
	
	# Landing
	var direction = Input.get_axis("left", "right")
	if player.is_on_floor():
		player.double_jumped = false
		if direction != 0:
			switch_state.emit(move_state)
		else:
			switch_state.emit(idle_state)
