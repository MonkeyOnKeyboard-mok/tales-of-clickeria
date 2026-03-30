extends Node
## enums
## consts
## exports
@export var stats : UnitStats 
## public vars
var target : Node2D = null
## private vars
## onready vars
@onready var attack : AttackComponent = %AttackScript
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

## public methods

func new_target(enemy: Node2D) -> void:
	print("minion target: ", enemy)
	attack.minion_attack(enemy)
	
## private methods
