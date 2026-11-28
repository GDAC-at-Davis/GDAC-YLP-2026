extends Node2D

@warning_ignore("unused_signal")
signal loading_screen_ready

@export var animation_player : AnimationPlayer

var animation_in_progress : bool = false;
var continuous : bool = false;
var can_fade_out : bool = false;

func _ready() -> void:
	pass
	#await animation_player.animation_finished
	#loading_screen_ready.emit()

func set_can_fade_out(set : bool = true):
	can_fade_out = set

func fade_out() -> void:
	if can_fade_out: 
		animation_player.stop()
		animation_player.play("fade_out")
	
func fade_out_continuously(set: bool = true) -> void: 
	continuous = set

func _process(_delta) -> void:
	if (continuous == true):
		if MelodicGameManager.metronome.check_perfect() and MelodicGameManager.metronome.check_new_measure():
			animation_player.stop()
			animation_player.play("fade_out_faster")
	#if MelodicGameManager.player:
		#MelodicGameManager.player.movement_stasis = true

# This is the loading screen's tracking of the loading progress, could use this function
# for visual things like progress bars and whatnot
#@warning_ignore("unused_parameter")
#func _on_progress_changed(new_value: float) -> void:
	#pass
#
#func _on_load_finished() -> void:
	#animation_player.play_backwards("transition")
	#await animation_player.animation_finished
	## MelodicGameManager.player.movement_stasis = false
	#queue_free()
	
