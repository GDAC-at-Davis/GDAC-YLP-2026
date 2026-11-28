extends State

@export var idle_state: State
@export var move_state: State
@export var player: CharacterBody2D

func enter_state() -> void:
	# Change to jump sprite
	
	# Handle Jump.
	player.velocity.y = player.jump_speed

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
		player.velocity.y = player.jump_speed
	
	# Cut jump velocity if jump button released
	if Input.is_action_just_released("a") and not player.is_on_floor() and player.velocity.y < 0:
		player.velocity.y /= 2
	
	# Landing
	var direction = Input.get_axis("left", "right")
	if player.is_on_floor():
		player.double_jumped = false
		if direction != 0:
			switch_state.emit(move_state)
		else:
			switch_state.emit(idle_state)
