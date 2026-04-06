extends Node
class_name MinionManager
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
func set_new_target(enemy: Node2D) -> void:   ## El target de los minions se settea cuando spawnea un enemigo
	for child in get_children():
		if child is Node2D:
			child.new_target(enemy)
			#print("minion new target set")

## private methods
