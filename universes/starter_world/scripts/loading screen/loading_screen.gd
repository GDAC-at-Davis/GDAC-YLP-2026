extends CanvasLayer

signal loading_screen_ready

@export var animation_player : AnimationPlayer

func _ready() -> void:
	await animation_player.animation_finished
	loading_screen_ready.emit()

func _process(_delta) -> void:
	if TestGameManager.player:
		TestGameManager.player.movement_stasis = true

# This is the loading screen's tracking of the loading progress, could use this function
# for visual things like progress bars and whatnot
func _on_progress_changed(new_value: float) -> void:
	pass

func _on_load_finished() -> void:
	animation_player.play_backwards("transition")
	await animation_player.animation_finished
	TestGameManager.player.movement_stasis = false
	queue_free()
