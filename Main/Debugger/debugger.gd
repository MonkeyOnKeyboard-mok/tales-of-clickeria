extends Node
## enums
## consts
## exports
## public vars
## private vars
## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

## public methods

## private methods


func _on_button_pressed() -> void:
	get_parent().spawn_enemy()


func _on_minion_spawner_pressed() -> void:
	get_parent().spawn_minion()
