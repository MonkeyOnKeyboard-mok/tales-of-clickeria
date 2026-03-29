extends Node
## enums
## consts
## exports
## public vars
var target : Node2D = null
## private vars
## onready vars
@onready var attack : AttackComponent = %AttackScript
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	_new_target()

func _process(_delta: float) -> void:
	pass

## public methods

func _new_target() -> void:
	target = get_tree().get_first_node_in_group("enemy")
	print(target)
	attack.minion_attack(target)
	
## private methods
