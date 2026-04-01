extends Node
## enums
## consts
const ENEMY = preload("uid://bboyklv1jcrnt")
const MINION = preload("uid://b8hthhw0wyov")
## exports
## public vars
signal enemy_just_died
var current_enemy : Node2D = null
## private vars
var enemy_position: Vector2 = Vector2(576,160)
## onready vars
@onready var minions: MinionManager = %MinionManager
@onready var player: Node2D = %Player
@onready var cards: CanvasLayer = %Upgrades
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
	minion_instance.stats = type
	minions.add_child(minion_instance)
	minion_instance.global_position = Vector2(400,400)
	print("minion spawned")

func enemy_died():
	print("ENEMY JUST DIED")
	emit_signal("enemy_just_died")

## private methods
