extends Node
class_name AttackComponent
## enums
## consts
## exports
## public vars
var base_damage : int = 1
var current_target : Node2D = null
## private vars
## onready vars
@onready var attack_timer: Timer = $Timer
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

## public methods
func minion_attack(enemy) -> void:
	current_target = enemy
	enemy.lifeBar.take_damage(1)
	print("El minion hizo daño")
	attack_timer.start()
## private methods


func _on_timer_timeout() -> void:
	minion_attack(current_target)
