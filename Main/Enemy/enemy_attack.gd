extends Node
class_name EnemyAttack
## enums
## consts
## exports
@export var stats : EnemyStats 
## public vars
signal enemy_attacked
## private vars
## onready vars
@onready var timer: Timer = $Timer

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	_set_stats()
	timer.start(stats.attack_speed)

func _process(_delta: float) -> void:
	pass

## public methods

## private methods
func _set_stats() -> void:
	stats.base_damage = 3.0
	stats.damage_type = "null"
	stats.crit_chance = 0.0
	stats.attack_speed = 3.0

func _on_timer_timeout() -> void:
	emit_signal("enemy_attacked")
