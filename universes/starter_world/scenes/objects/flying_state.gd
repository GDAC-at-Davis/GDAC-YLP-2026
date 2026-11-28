extends State

@export var ground_state: State
@export var player: CharacterBody2D

@export var initial_state: State

var active_state: State:
	set(new_value):
		active_state = new_value
		# Debug: Detecting changes in state
		print("changed flying state to: " + str(active_state.name))

func enter_state() -> void:
	for child_state: State in get_children():
		child_state.switch_state.connect(change_state)
	
	change_state(initial_state)
	
	#active_state.enter_state()

func exit_state() -> void:
	pass
	#active_state.exit_state()

func update(_delta: float) -> void:
	if active_state:
		active_state.update(_delta)

func physics_update(delta: float) -> void:
	# Flying specific stuff
	if Input.is_action_just_pressed("custom_1"):
		player.spawn_afterimage(Color(1,1,1,1), 0.5, 0.5, 3)
		switch_state.emit(ground_state)
	
	if !Engine.get_physics_frames()%10:
		player.spawn_afterimage(Color(0.543, 0.773, 1.0, 1.0))
	
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
