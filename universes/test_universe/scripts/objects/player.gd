extends CharacterBody2D

var speed = 300.0
var shift_speed = 600.0
var jump_speed = -400.0
var crouching = false

func _physics_process(delta):
	
	if Input.is_action_just_pressed("down"):
		crouching = not crouching
	
	if crouching:
		speed = 150.0
	else:
		speed = 300.0
	# Add the gravity.
	velocity += get_gravity() * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("left", "right")
	if Input.is_action_pressed("Run") and direction and crouching != true:
		velocity.x = direction * shift_speed
	else:
		velocity.x = direction * speed
	
	if direction != 0:
		var facing_right = direction > 0
		$AnimatedSprite2D.flip_h = !facing_right

	move_and_slide()
	
	
	
	
	
var MaskOn = false
var Mask_Timer = 10.0
#if u dont know and are reading this, delta is the time since last frame
func mask(delta):
	if Input.is_action_just_pressed("Equip_Mask") and Mask_Timer >= 3.0:
		MaskOn = true
	if MaskOn:
		Mask_Timer -= delta
		
		if Mask_Timer <= 0.0:
			MaskOn = false
	else:
		MaskOn = false
		Mask_Timer += delta
		Mask_Timer = min(Mask_Timer, 10.0)
