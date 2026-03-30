extends Node
## enums
## consts
## exports
## public vars
var dragging := false
var offset := Vector2.ZERO
## private vars
## onready vars
@onready var area_2d: Area2D = $Area2D
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if dragging:
		get_parent().global_position = get_parent().global_position.lerp(get_viewport().get_mouse_position() + offset, 0.4)
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed:
			dragging = false
## public methods

## private methods
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("click")
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		print("click")
		dragging = event.pressed
		offset = self.global_position - get_viewport().get_mouse_position()
