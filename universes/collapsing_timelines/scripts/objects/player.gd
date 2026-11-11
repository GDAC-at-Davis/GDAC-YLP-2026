extends PossessableCharacter

var speed = 300.0
var jump_speed = -400.0

func _physics_process(delta):
	# Add the gravity.
	velocity += get_gravity() * delta

	move_and_slide()
	
func handle_jump(force: bool = false) -> void:
	if (!_is_possessed && !force): return
	# Handle Jump.
	if (!is_on_floor()):
		return
	velocity.y = jump_speed

func handle_movement(horizontal_input: float, force: bool = false) -> void:
	if (!_is_possessed && !force): return
	
	# Get the input direction.
	velocity.x = horizontal_input * speed
	
	if horizontal_input != 0:
		var facing_right = horizontal_input > 0
		$Sprite2D.flip_h = !facing_right
