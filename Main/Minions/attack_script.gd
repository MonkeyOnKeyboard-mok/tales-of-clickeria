extends Node
class_name AttackComponent
## enums
## consts
const PROJECTILE = preload("uid://bcpb5orwfprdb")
## exports
## public vars
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
func minion_attack(enemy) -> void:  ## Version con proyectil
	var projectile = PROJECTILE.instantiate()
	projectile.global_position = get_parent().global_position
	if enemy:
		current_target = enemy
		var direction = (current_target.global_position - get_parent().global_position).normalized()
		projectile.direction = direction
		get_parent().sprite.play("attack")
		await get_parent().sprite.animation_finished
		add_child(projectile)
		get_parent().sprite.play("idle")
		projectile.anim.play(get_parent().stats.type)
		print("El minion tiró un camotito")
		attack_timer.start(get_parent().stats.attack_speed)

## private methods

func _on_timer_timeout() -> void:
	minion_attack(current_target)
