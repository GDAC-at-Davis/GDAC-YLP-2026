extends Area2D

@export var player: PossessableCharacter
@export var interact_prompt: Label

var available_interactables: Array[Interactable]
var selected_interactable: Interactable

func _ready() -> void:
	player.on_possessed_changed.connect(update_selected_interactable)
	update_selected_interactable()

func _process(_delta: float) -> void:
	if (selected_interactable == null || !player._is_possessed): return
	
	if Input.is_action_just_pressed("b"):
		selected_interactable.interact()
		# Interactables may only be able to be interacted with once
		update_selected_interactable()
	
	if (selected_interactable == null): return
	
	interact_prompt.global_position = selected_interactable.global_position - interact_prompt.size / 2

func _on_area_entered(area: Area2D) -> void:
	if area is not Interactable: return
	
	available_interactables.append(area)
	update_selected_interactable()


func _on_area_exited(area: Area2D) -> void:
	if area is not Interactable: return
	
	available_interactables.erase(area)
	update_selected_interactable()
	
func update_selected_interactable() -> void:
	selected_interactable = null
	var current_closest_dist: float = 999999;
	
	for interactable in available_interactables:
		if (!interactable.can_interact): continue
		
		var dist: float = (interactable.global_position - global_position).length()
		if dist < current_closest_dist:
			current_closest_dist = dist
			selected_interactable = interactable
	
	interact_prompt.visible = selected_interactable != null && player._is_possessed
