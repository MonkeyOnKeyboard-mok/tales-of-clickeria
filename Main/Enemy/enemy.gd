extends Node
## enums
## consts
## exports
## public vars
## private vars
## onready vars
@onready var lifeBar : HealthBar = %HealthBar

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	add_to_group("enemy")
	#get_parent().enemy_spawned(self) # BORRAR

func _process(_delta: float) -> void:
	pass

## public methods

## private methods


func _on_area_2d_input_event(_viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		lifeBar.take_damage(1)
