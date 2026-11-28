extends State

@export var idle_state: State
@export var jump_state: State
@export var player: CharacterBody2D

func enter_state() -> void:
	# Change to movement sprite
	pass

func exit_state() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	# Move player in the direction of the input multiplied by their movement speed
	get_parent().handle_movement(delta)
		
	if is_zero_approx(player.velocity.x):
		switch_state.emit(idle_state)
		
	
	if Input.is_action_just_pressed("a") and player.is_on_floor():
		switch_state.emit(jump_state)
