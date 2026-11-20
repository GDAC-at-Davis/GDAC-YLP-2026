class_name InteractableArea
extends Area2D

signal Interact()

@onready var indicator: Label = $Indicator

func _ready() -> void:
	indicator.hide()

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		indicator.show()


func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		indicator.hide()
