extends CharacterBody2D
class_name DFMSPlayer

## Dystopian Face Mask Society Player
##
## Main controllable object for the Dystopian Face Mask Society universe.

# Reserves the following input map scheme:
#   Left, Right =  Horizontal Movement
#   Down = Crouch
#   a = Jump
#   b = Run
#   custom_1 = Equip Mask


#PLAYER SPEEDS
var speed = 300.0
var shift_speed = 600.0
var jump_speed = -400.0
var crouch_speed = 150.0
#PLAYER STATES
var crouching = false
var Mask = false
var sprinting = false

func _physics_process(delta):
	
	#Crouching 
	if Input.is_action_just_pressed("down"):
		crouching = not crouching
	if crouching:
		speed = crouch_speed
	else:
		speed = 300.0
		
	# Add the gravity.
	velocity += get_gravity() * delta

	# Handle Jump.
	if Input.is_action_just_pressed("a") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("left", "right")
	
	sprinting = Input.is_action_pressed("b")
	
	if direction and crouching != true:
		if sprinting:
			velocity.x = direction * shift_speed
		else:
			velocity.x = direction * speed
	elif direction and crouching:
		velocity.x = direction * crouch_speed
		if sprinting:
			crouching = false
	else:
		velocity.x = 0
	
	if direction != 0:
		var facing_right = direction > 0
		$AnimatedSprite2D.flip_h = !facing_right

	move_and_slide()
	
	# Debug: Detecting button inputs 
	var inputs = ["a", "b", "c", "custom_1", "custom_2", "custom_3"]
	for i in inputs:
		if Input.is_action_just_pressed(i):
			print(i)


var Mask_Timer = 10.0
#if u dont know and are reading this, delta is the time since last frame
func mask(delta):
	if Input.is_action_just_pressed("custom_1") and Mask_Timer >= 3.0:
		Mask = true
	if Mask:
		Mask_Timer -= delta
		
		if Mask_Timer <= 0.0:
			Mask = false
	else:
		Mask = false
		Mask_Timer += delta
		Mask_Timer = min(Mask_Timer, 10.0)
