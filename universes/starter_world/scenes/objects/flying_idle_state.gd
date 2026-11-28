extends State

@export var move_state: State
@export var player: CharacterBody2D

func enter_state() -> void:
	# Change to idle sprite
	pass

func exit_state() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	# When any direction is inputted, change to move state
	if Input.get_vector("left", "right", "up", "down") != Vector2.ZERO:
		switch_state.emit(move_state)
	else:
		player.velocity = lerp(player.velocity, Vector2(0,0), 10 * delta)
