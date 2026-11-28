extends CharacterBody2D

var move_speed := 200.0
var jump_speed := -400.0

var ground_acceleration = 1600.0
var ground_friction = 800.0

var movement_stasis : bool = false
var in_dialogue : bool = false

var double_jumped : bool = false

@onready var sprite : Sprite2D = $Sprite2D
@onready var silhouette_shader : Shader = preload("uid://bifoe57rj0l6h")

func _physics_process(_delta) -> void:
	#print("in_dialogue " + str(in_dialogue))
	#print("movement_stasis " + str(movement_stasis))
	if in_dialogue:
		movement_stasis = true
	if not movement_stasis:
		# Get the input direction.
		var direction = Input.get_axis("left", "right")
		
		if direction != 0:
			var facing_right = direction > 0
			$Sprite2D.flip_h = !facing_right
		
		move_and_slide()
	
	# Debug: Detecting button inputs 
	#var inputs = ["a", "b", "c", "custom_1", "custom_2", "custom_3"]
	#for i in inputs:
		#if Input.is_action_just_pressed(i):
			#print(i)

func spawn_afterimage(
	afterimage_color: Color = Color(1, 1, 1, 1), 
	fade_duration: float = 0.6, 
	scale_duration: float = 0.6, 
	target_scale: float = 2.0
) -> void:
	var shader_material = ShaderMaterial.new()
	shader_material.shader = silhouette_shader
	shader_material.set_shader_parameter("silhouette_color", afterimage_color)
	
	var active_texture = sprite.texture
	
	# for when we get sprite animations
	#var sprite_frames = sprite.sprite_frames
	#var current_animation = sprite.animation
	#var current_frame_index = sprite.frame
	#var active_texture = sprite_frames.get_frame_texture(current_animation, current_frame_index)
	
	var img = Sprite2D.new()
	img.texture = active_texture
	img.global_position = global_position
	img.flip_h = sprite.flip_h
	img.scale = sprite.scale
	
	img.material = shader_material
	
	get_tree().current_scene.add_child(img)
	
	var tween = create_tween()
	# Transparency fade
	tween.tween_property(img, "modulate:a", 0.0, fade_duration)
	tween.parallel().tween_method(silhouette_shader_set_transparency.bind(img.material), 1.0, 0.0, fade_duration)
	# Scale growth
	tween.parallel().tween_property(img, "scale", sprite.scale * target_scale, scale_duration)
	tween.tween_callback(img.queue_free)

func silhouette_shader_set_transparency(new_value: float, mat: ShaderMaterial) -> void:
	mat.set_shader_parameter("transparency", new_value)
