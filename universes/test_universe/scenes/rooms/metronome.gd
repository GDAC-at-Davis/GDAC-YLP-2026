extends Node

@export var bpm: float = 120.0
@export var beats_per_measure: int = 4

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var timer: Timer = $Timer

var current_beat: int = 0

func _ready() -> void:
	var interval = 45.0 / bpm
	timer.wait_time = interval
	timer.timeout.connect(_on_beat_timeout)
	timer.start()

func _on_beat_timeout() -> void:
	audio_player.play()
	current_beat = (current_beat % beats_per_measure) + 1
	# print("Beat: ", current_beat) # Useful for debugging rhythm sync
