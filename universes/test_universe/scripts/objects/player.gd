extends CharacterBody2D

var speed = 320.0
var jump_speed = -400.0

func _physics_process(delta):
	# Add the gravity.
	velocity += get_gravity() * delta

	# Handle Jump.
	if Input.is_action_just_pressed("a") and is_on_floor():
		velocity.y = jump_speed

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
