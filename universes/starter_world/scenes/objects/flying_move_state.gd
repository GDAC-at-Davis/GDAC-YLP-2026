extends State

@export var idle_state: State
@export var player: CharacterBody2D

func enter_state() -> void:
	# Change to movement sprite
	pass

func exit_state() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	# Move player in the direction of the input multiplied by their movement speed
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		player.velocity = direction * player.move_speed
	else:
		# When no directions are inputted anymore, change to idle state
		switch_state.emit(idle_state)
