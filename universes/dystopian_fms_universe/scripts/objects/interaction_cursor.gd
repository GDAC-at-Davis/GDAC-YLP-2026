extends CharacterBody2D
class_name DFMSInteractionCursor

## Dystopian Face Mask Society Interaction Cursor
##
## A cursor that is player-controllable, used to select interactable objects
## for Gee. 

# Reserves the following input map scheme:
# Left, Right, Up, Down - Cursor Movement
# ? - Select Hovered Object
# ? - Exit Selection Mode



signal cursor_selected_interactable(DFMSInteractableObject)
signal cursor_failed_selection
signal cursor_exit_selection


@export_group("Dependencies")
@export var interaction_zone: DFMSInteractableZone
@export_group("")
@export var is_active: bool
@export var cursor_move_speed: float = 200.0

var _move_direction: Vector2 = Vector2.ZERO
var _hovered_zones_queue: Array[DFMSInteractableZone] = []
var _currently_hovered_zone: DFMSInteractableZone


func _ready():
	visible = false
	_hovered_zones_queue.clear()
	_currently_hovered_zone = null
	set_physics_process(false)
	interaction_zone.area_entered.connect(_on_area_entered)
	interaction_zone.area_exited.connect(_on_area_exited)


func _physics_process(delta: float) -> void:
	_move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	_move_direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = _move_direction.normalized() * cursor_move_speed * delta
	move_and_slide()


func activate():
	visible = true
	set_physics_process(true)


func deactivate():
	visible = false
	_hovered_zones_queue.clear()
	_currently_hovered_zone = null
	set_physics_process(false)
	cursor_exit_selection.emit()


func _on_area_entered(area: Area2D):
	if area is DFMSInteractableZone:
		_hovered_zones_queue.push_front(area)
		_update_hovered_zones_queue()


func _on_area_exited(area: Area2D):
	if area is DFMSInteractableZone:
		if _hovered_zones_queue.has(area):
			_hovered_zones_queue.erase(area)
			_update_hovered_zones_queue()
		else:
			push_warning("Interactable cursor tried to dequeue zone not in list.")


func _update_hovered_zones_queue():
	var temp_hovered_zone = _currently_hovered_zone
	_currently_hovered_zone = _hovered_zones_queue.front()
	if _currently_hovered_zone != temp_hovered_zone:
		_currently_hovered_zone.hovered.emit()
		temp_hovered_zone.dehovered.emit()


func _select_hovered_object():
	if _currently_hovered_zone == null:
		pass
	else:
		cursor_selected_interactable.emit(_currently_hovered_zone.host)
		deactivate()


func _on_cursor_enter_selection(player_position: Vector2):
	global_position = player_position
	activate()
