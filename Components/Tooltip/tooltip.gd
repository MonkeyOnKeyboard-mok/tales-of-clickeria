extends Panel
## enums
## consts
## exports
## public vars
## private vars
var parent: Node2D = null
var parent_type : String = " "
## onready vars
@onready var label: RichTextLabel = $RichTextLabel
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	_set_size_custom()
	hide()

func _process(_delta: float) -> void:
	_set_info()

## public methods

## private methods

func _set_size_custom()-> void:
	if get_parent().is_in_group("minion"):
		self.custom_minimum_size = Vector2(800,500)
		label.custom_minimum_size = Vector2(800,500)
		parent = get_parent()
		parent_type = "minion"

func _set_info()-> void:
	match parent_type:
		"minion":
			label.text = "\b Level: \b" + str(int(parent.level)) + "\n" \
			+ "\b Element: \b" + parent.stats.type + "\n" \
			 + "\b Damage: \b" + str(int(parent.calculate_damage()))  

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		# If tooltip is visible and the click is outside it → hide
		if self.visible:
			var mouse_pos = get_viewport().get_mouse_position()
			if not self.get_global_rect().has_point(mouse_pos):
				hide()
