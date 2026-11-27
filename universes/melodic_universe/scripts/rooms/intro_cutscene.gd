extends Node2D

@export var metronome = Node2D
@export var darkness = Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MelodicGameManager.metronome = metronome
	MelodicGameManager.darkness = darkness


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
