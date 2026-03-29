extends Node
## enums
## consts
## exports
## public vars
var current_enemy : Node2D = null
## private vars
## onready vars
@onready var minions: MinionManager = %MinionManager
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

## public methods
func enemy_spawned(enemy: Node2D) -> void:
	current_enemy = enemy
	print("monono spawned")
	
## private methods
