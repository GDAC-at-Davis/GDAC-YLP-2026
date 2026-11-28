extends Node

@export var bpm: float = 120.0
@export var beats_per_measure: int = 4
@export var num_sub_beats: int = 6

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var timer: Timer = $Timer

var mute: bool = false

enum OnBeat {PERFECT, GREAT, GOOD, BAD}

var current_beat: int = 0
var on_beat: OnBeat = OnBeat.BAD;

func print_on_beat():
	match on_beat:
		OnBeat.PERFECT:
			print("PERFECT!")
		OnBeat.GREAT:
			print("GREAT!")
		OnBeat.GOOD:
			print("GOOD!")
		OnBeat.BAD:
			print("BAD!")

func check_perfect() -> bool:
	if on_beat == OnBeat.PERFECT:
		return true
	return false

func check_new_measure() -> bool:
	if (current_beat / num_sub_beats) % beats_per_measure == 0:
		return true
	return false

func mute_metronome(set: bool = true) -> void:
	mute = set
	
func _ready() -> void:
	current_beat = 0;
	var interval = 60.0 / bpm
	timer.wait_time = interval / num_sub_beats
	timer.timeout.connect(_on_beat_timeout)
	timer.start()

func _on_beat_timeout() -> void:
	current_beat += 1
	var current_sub_beat = current_beat % num_sub_beats
	
	# for num_sub_beats >= 6
	if (current_sub_beat == 0):
		if not mute:
			audio_player.play()
		on_beat = OnBeat.PERFECT
		print(check_new_measure())
		# print("  PERFECT!")
	elif (current_sub_beat == 1):
		audio_player.stop()
		on_beat = OnBeat.PERFECT
		# print("  PERFECT!")
	elif (current_sub_beat == 2 || current_sub_beat == num_sub_beats - 1):
		on_beat = OnBeat.GOOD
		# print("      GOOD!")
	else:
		on_beat = OnBeat.BAD
		# print("        BAD!")
	
	# DEBUGGING:
	# print_on_beat()
	# print("  Current Beat: ", current_beat) # Useful for debugging rhythm sync
	# print("  Current Sub-beat: ", current_sub_beat)
	# print("  Current Beat / Sub-beats: ", current_beat / num_sub_beats)
