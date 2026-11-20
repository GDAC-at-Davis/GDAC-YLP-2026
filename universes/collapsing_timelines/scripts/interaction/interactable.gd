extends Area2D

class_name Interactable

signal on_interacted

var can_interact: bool = true

func interact() -> void:
	on_interacted.emit()
	print("Interacted with ", self)
