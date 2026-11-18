class_name PlayerBase
extends Character 


var _dead:bool = false

var double_jump : bool: 
	set(value): 
		double_jump = value
	get():
		return double_jump

@onready var animation_tree:AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true
	bind_player_input_commands()
	#command_callback("undeath")


func _physics_process(delta: float):
	if _dead:
		return

	var move_input = Input.get_action_strength("right") - Input.get_action_strength("left")

	if Input.is_action_just_pressed("up"):
		up_cmd.execute(self)
		#command_callback("jump")
	
	if move_input > 0.1:
		right_cmd.execute(self)
	elif move_input < -0.1:
		left_cmd.execute(self)
	else:
		idle.execute(self)
	
	super(delta)
	
	if is_on_floor():
		double_jump = true
	
	_manage_animation_tree_state()


func bind_player_input_commands():
	right_cmd = MoveCommand.new(true)
	left_cmd = MoveCommand.new()
	up_cmd = JumpCommand.new()
	#fire1 = AttackCommand.new()
	idle = IdleCommand.new()


func unbind_player_input_commands():
	right_cmd = IdleCommand.new()
	left_cmd = IdleCommand.new()
	up_cmd = IdleCommand.new()
	fire1 = IdleCommand.new()
	idle = IdleCommand.new()


func resurrect() -> void:
	_dead = false
	animation_tree.active = true
	var sm:AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
	command_callback("undeath")
	sm.travel("summon")


func command_callback(cmd_name:String) -> void:
	if "attack" == cmd_name:
		_play($Audio/attack)
		
	if "jump" == cmd_name:
		_play($Audio/jump)
		
	if "engage" == cmd_name:
		_play($Audio/engage)
		
	if "undeath" == cmd_name:
		_play($Audio/undeath)


#Logic to support the state machine in the AnimationTree
func _manage_animation_tree_state() -> void:
	if !is_zero_approx(velocity.x):
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/moving"] = true
	else:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/moving"] = false
	
	if is_on_floor():
		animation_tree["parameters/conditions/jumping"] = false
		animation_tree["parameters/conditions/on_floor"] = true
	else:
		animation_tree["parameters/conditions/jumping"] = true
		animation_tree["parameters/conditions/on_floor"] = false


func _play(player:AudioStreamPlayer2D) -> void:
	if !player.playing:
		player.play()
