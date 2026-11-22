extends Node

signal progress_changed(progress)
signal load_finished

var loading_screen : PackedScene = preload("uid://d2emu8ukol53t")
var loaded_resource : PackedScene
var scene_path : String
var progress : Array = []
var use_sub_threads : bool = true

func _ready() -> void:
	set_process(false)

func load_scene(_scene_path: String) -> void:
	scene_path = _scene_path
	
	# Start loading screen
	var new_load_screen = loading_screen.instantiate()
	add_child(new_load_screen)
	
	progress_changed.connect(new_load_screen._on_progress_changed)
	load_finished.connect(new_load_screen._on_load_finished)
	
	await new_load_screen.loading_screen_ready
	
	start_load()

func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)

func _process(_delta: float) -> void:
	# Keep track of loading progress
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	progress_changed.emit(progress[0])
	
	match load_status:
		# If something went wrong with loading the resource
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		# Otherwise, set our loaded resource to the scene path that was loaded by resourceloader
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			# Now that the resource is loaded, we can finally switch to the scene
			get_tree().change_scene_to_packed(loaded_resource)
			load_finished.emit()
