extends Node
## enums
## consts
const ENEMY = preload("uid://bboyklv1jcrnt")
const MINION = preload("uid://b8hthhw0wyov")
## exports
## public vars
var current_enemy : Node2D = null
## private vars
var enemy_position: Vector2 = Vector2(576,160)
## onready vars
@onready var minions: MinionManager = %MinionManager
@onready var player: Node2D = %Player
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

## public methods
func spawn_enemy() -> void:
	var enenmy_instance = ENEMY.instantiate()
	add_child(enenmy_instance)
	enenmy_instance.global_position = enemy_position
	current_enemy = enenmy_instance
	print("monono spawned")
	minions.set_new_target(current_enemy)
	
func spawn_minion(type : UnitStats) -> void:
	var minion_instance = MINION.instantiate()
	minions.add_child(minion_instance)
	minion_instance.stats = type
	#minions.arrange_children()
	minion_instance.global_position = Vector2(400,400)
	print("minion spawned")

## private methods
