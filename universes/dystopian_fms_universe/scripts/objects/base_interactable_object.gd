extends StaticBody2D
class_name DFMSInteractableObject

@export_group("Dependencies")
@export var collision_box: CollisionShape2D
@export var sprite: Sprite2D

@export_group("")
@export var has_collision: bool = false:
	set(new_collision):
		collision_box.disabled = not new_collision
		has_collision = new_collision
	get:
		return has_collision
