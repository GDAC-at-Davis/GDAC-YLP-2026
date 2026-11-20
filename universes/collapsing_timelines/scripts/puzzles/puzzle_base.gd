extends Node2D

class_name PuzzleBase

@export var required_puzzle: PuzzleBase
@export var interactable: Interactable
@export var enable_when_completed: Array[Node2D]

func _ready() -> void:	
	if (required_puzzle == null): return
	
	visible = false
	for node in enable_when_completed:
		node.disabled = true
		
	required_puzzle.interactable.on_interacted.connect(on_required_interact)

func on_required_interact() -> void:
	visible = true
	for node in enable_when_completed:
		node.disabled = false
