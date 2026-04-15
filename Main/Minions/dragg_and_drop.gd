extends Node
class_name DragAndDrop
## enums
## consts
## exports
var bounds : CollisionShape2D
## public vars
signal show_tooltip
var dragging := false
var rotating := false
var offset := Vector2.ZERO
var within_bounds := false 
static var current_dragged = null
## private vars
## onready vars
@onready var area_2d: Area2D = $Area2D
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if !within_bounds: return
	if dragging and current_dragged == self and !rotating:
		get_parent().global_position = get_parent().global_position.lerp(get_viewport().get_mouse_position() + offset, 0.4)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed:
			if current_dragged == self:
				dragging = false
				current_dragged = null
				if get_parent().is_in_group("potion"):
					get_parent().try_level_up()
				if get_parent().is_in_group("minion"):
					get_parent().try_sell()
					GlobalStats.dragging_minion = false


## public methods

## private methods
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if current_dragged == null:
				current_dragged = self
				dragging = event.pressed
				if get_parent().is_in_group("minion"):
					GlobalStats.dragging_minion = true
				offset = self.global_position - get_viewport().get_mouse_position()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			emit_signal("show_tooltip")
			print("showing tooltip")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if get_parent().is_in_group("minion") or get_parent().is_in_group("hourglass"):
		if area.is_in_group("minion_bounds"):
			within_bounds = true
			print("within bounds")
			print(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if get_parent().is_in_group("minion") or get_parent().is_in_group("hourglass"):
		if area.is_in_group("minion_bounds"):
			within_bounds = false
			get_parent().push_back()
			print("out of bounds")
			print(area)
