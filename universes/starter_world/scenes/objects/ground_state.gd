extends State

@export var flying_state: State
@export var player: CharacterBody2D

@export var initial_state: State
@export var fall_state: State

var active_state: State:
	set(new_value):
		active_state = new_value
		# Debug: Detecting changes in state
		print("changed grounded state to: " + str(active_state.name))

func enter_state() -> void:
	for child_state: State in get_children():
		child_state.switch_state.connect(change_state)
	
	if player.is_on_floor():
		change_state(initial_state)
	else:
		change_state(fall_state)
	
	#active_state.enter_state()

func exit_state() -> void:
	pass
	#active_state.exit_state()

func update(_delta: float) -> void:
	if active_state:
		active_state.update(_delta)

func physics_update(delta: float) -> void:
	# Grounded specific stuff
	
	# Switch to flying mode with Custom 1
	if Input.is_action_just_pressed("custom_1"):
		switch_state.emit(flying_state)
	
	# Gravity affects you when in grounded mode
	player.velocity += player.get_gravity() * delta
	
	# Recharge double jump
	if player.is_on_floor():
		player.double_jumped = false
	
	# Switch to fall state is player is, well, falling
	if not player.is_on_floor() and player.velocity.y > 0:
		change_state(fall_state)
	
	
	if active_state:
		active_state.physics_update(delta)

func change_state(new_state: State) -> void:
	if new_state == active_state:
		return
	if new_state.get_parent() != self:
		push_error(new_state.name + " is not a state of StateMachine " + self.name + "!")
	
	if active_state:
		active_state.exit_state()
	
	active_state = new_state
	
	if active_state:
		active_state.enter_state()

func handle_movement(delta: float) -> void:
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		player.velocity.x = move_toward(player.velocity.x, direction * player.move_speed, player.ground_acceleration * delta)
	else:
		# When no directions are inputted anymore, apply friction and change to idle state when not moving
		player.velocity.x = move_toward(player.velocity.x, 0, player.ground_friction * delta)
