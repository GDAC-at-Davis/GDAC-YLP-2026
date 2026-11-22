extends CharacterBody2D

var speed = 320.0
var jump_speed = -400.0

var movement_stasis : bool = false
var in_dialogue : bool = false

var double_jumped : bool = false

func _physics_process(delta):
	#print("in_dialogue " + str(in_dialogue))
	#print("movement_stasis " + str(movement_stasis))
	if in_dialogue:
		movement_stasis = true
	if not movement_stasis:
		# Add the gravity.
		velocity += get_gravity() * delta
	
		# Handle Jump.
		if Input.is_action_just_pressed("a") and is_on_floor():
			velocity.y = jump_speed
		
		# Double Jump
		if Input.is_action_just_pressed("a") and not is_on_floor() and not double_jumped:
			double_jumped = true
			velocity.y = jump_speed
		
		if Input.is_action_just_released("a") and not is_on_floor() and velocity.y < 0:
			velocity.y /= 2
		
		if is_on_floor():
			double_jumped = false

		# Get the input direction.
		var direction = Input.get_axis("left", "right")
		velocity.x = direction * speed
		
		if direction != 0:
			var facing_right = direction > 0
			$Sprite2D.flip_h = !facing_right
			

		move_and_slide()
	
	# Debug: Detecting button inputs 
	var inputs = ["a", "b", "c", "custom_1", "custom_2", "custom_3"]
	for i in inputs:
		if Input.is_action_just_pressed(i):
			print(i)
