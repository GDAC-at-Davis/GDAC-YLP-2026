extends StaticBody2D
class_name DFMSInteractableObject

@export_group("Dependencies")
@export var collision_box: CollisionShape2D
@export var sprite: Sprite2D

@export_group("")
@export var is_currently_active: bool = true:
	set(new_value):
		is_currently_active = new_value
		set_instance_shader_parameter("is_glowing", new_value)
	get:
		return is_currently_active
@export var has_collision: bool = false:
	set(new_collision):
		collision_box.disabled = not new_collision
		has_collision = new_collision
	get:
		return has_collision
