extends Node
class_name AttackComponent
## enums
## consts
## exports
## public vars
## private vars
var target : Node2D = null
## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	_new_target()

func _process(_delta: float) -> void:
	pass

## public methods

## private methods

func _new_target() -> void:
	target = get_tree().get_first_node_in_group("enemy")
	print(target)
