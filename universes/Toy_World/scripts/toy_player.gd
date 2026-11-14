extends CharacterBody2D

var speed = 300.0
var jump_speed = -400.0
var jump_counter = 0


func _physics_process(delta):
	# Add the gravity.
	if is_on_floor():
		jump_counter = 0
	
	velocity += get_gravity() * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if(jump_counter <= 1):
			velocity.y += jump_speed
			jump_counter += 1

	# Get the input direction.
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * speed
	
	if direction != 0:
		var facing_right = direction > 0
		$Sprite2D.flip_h = !facing_right

	move_and_slide()
