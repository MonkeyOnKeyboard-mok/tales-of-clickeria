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
	Event.enemy_died.connect(_stop_timer)

func _process(_delta: float) -> void:
	pass

## public methods

func set_target(enemy) -> void: 
	current_target = enemy
	if not attack_timer.is_stopped():
		print("Attack timer is on, returning...")
		return
	else: 
		print("Attack timer is off, starting it...")
		_launch_projectile(current_target)

## private methods

func _launch_projectile(enemy) -> void:
	var projectile = PROJECTILE.instantiate()
	#print("minion position: ",get_parent().global_position, "projectile position", projectile.global_position)
	current_target = enemy
	get_parent().sprite.play("attack")
	await get_parent().sprite.animation_finished
	var direction = (current_target.global_position - get_parent().global_position).normalized()
	projectile.direction = direction
	add_child(projectile)
	projectile.global_position = get_parent().global_position
	get_parent().sprite.play("idle")
	projectile.anim.play(get_parent().stats.type)
	#print("El minion tiró un camotito")
	attack_timer.start(get_parent().current_attack_speed)

func _on_timer_timeout() -> void:
	_launch_projectile(current_target)

func _stop_timer() -> void:
	print("Attack Timer off")
	attack_timer.stop()
	print("Timer stopped?", attack_timer.is_stopped())
