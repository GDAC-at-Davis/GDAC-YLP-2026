extends CharacterBody2D

var speed = 300.0
var jump_speed = -400.0
var movement_stasis : bool = false
var in_dialogue : bool = false

func _ready() -> void:
	pass
	
func _physics_process(delta):
	if not movement_stasis:
		# Add the gravity.
		velocity += get_gravity() * delta

		# Handle Jump.
		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = jump_speed

		# Get the input direction.
		var direction = Input.get_axis("left", "right")
		velocity.x = direction * speed
		
		if direction != 0:
			var facing_right = direction > 0
			$Sprite2D.flip_h = !facing_right
		
		move_and_slide()
	
	# Beat sync
	if Input.is_action_just_pressed("melodic-beat"):
		MelodicGameManager.metronome.print_on_beat()
		
		if not (MelodicGameManager.darkness == null):
			MelodicGameManager.darkness.fade_out()
	
	# Debug: Detecting button inputs 
	# custom_1: shift, space
	# custom_2: q
	# custom_3: e
	#var inputs = ["a", "b", "c", "custom_1", "custom_2", "custom_3"]
	#for i in inputs:
		#if Input.is_action_just_pressed(i):
			#print(i)
