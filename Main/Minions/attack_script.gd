extends Node
class_name AttackComponent
## enums
## consts
const PROJECTILE = preload("uid://bcpb5orwfprdb")
## exports
## public vars
var current_target : Node2D = null
var enemy_position: Vector2 = Vector2(576,160)
var spell_echo : bool = false
## private vars
## onready vars
@onready var attack_timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $"../Sprite2D"

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
		#print("Attack timer is on, returning...")
		return
	else: 
		#print("Attack timer is off, starting it...")
		if current_target:
			if spell_echo:
				_spell_echo()
			else:
				_launch_projectile()
			

## private methods

func _launch_projectile() -> void:
	var projectile = PROJECTILE.instantiate()
	#print("minion position: ",get_parent().global_position, "projectile position", projectile.global_position)
	get_parent().sprite.play(get_parent().attack_anim)
	await get_parent().sprite.animation_finished
	var direction = (enemy_position - get_parent().global_position).normalized()
	projectile.direction = direction
	if get_parent().dying: return
	add_child(projectile)
	projectile.add_to_group("player_projectile")
	projectile.global_position = get_parent().global_position
	get_parent().sprite.play(get_parent().idle_anim)
	projectile.anim.play(get_parent().stats.type)
	#print("El minion tiró un camotito")
	attack_timer.start(get_parent().current_attack_speed)

func _on_timer_timeout() -> void:
	if current_target:
		if spell_echo:
			_spell_echo()
		else:
			_launch_projectile()

func _stop_timer() -> void:
	attack_timer.stop()

func _spell_echo() -> void:
	var projectile = PROJECTILE.instantiate()
	var projectiles = [projectile, projectile.duplicate(), projectile.duplicate()]
	#print("minion position: ",get_parent().global_position, "projectile position", projectile.global_position)
	get_parent().sprite.play(get_parent().attack_anim)
	await get_parent().sprite.animation_finished
	var direction = (enemy_position - get_parent().global_position).normalized()
	var offset := Vector2.ZERO
	for proj in projectiles:
		proj.direction = direction
		if get_parent().dying: return
		add_child(proj)
		proj.add_to_group("player_projectile")
		proj.global_position = get_parent().global_position + offset
		get_parent().sprite.play(get_parent().idle_anim)
		proj.anim.play(get_parent().stats.type)
		#print("El minion tiró un camotito")
		attack_timer.start(get_parent().current_attack_speed)
		offset += Vector2(20,20)
