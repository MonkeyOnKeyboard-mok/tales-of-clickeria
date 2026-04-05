extends Node
## enums
## consts
const ENEMY = preload("uid://bboyklv1jcrnt")
const MINION = preload("uid://b8hthhw0wyov")
const HOURGLASS = preload("uid://cl0r173uf860r")
## exports
## public vars
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
	## Connect to relevant signals
	Event.enemy_died.connect(spawn_enemy)
	Event.spawn_enemy.connect(spawn_enemy)
	Event.spawn_minion.connect(spawn_minion)
	Event.upgrade_chosen.connect(hide_upgrades)
	Event.spawn_hourglass.connect(spawn_hourglass)
	## Reset all stats
	GlobalStats.reset_stats()

func _process(_delta: float) -> void:
	pass

## public methods
func spawn_enemy() -> void:
	var tries : = 0
	await get_tree().create_timer(2.5).timeout
	while _has_enemy_child() and tries <6:  ### Para que no spawnee más de un enemigo a la vez
		print("ya existe un enemigo en escena") 
		tries += 1
		print("tried(",tries, ")times")
		await get_tree().create_timer(1.0).timeout
	if tries == 6: 
		if _is_enemy_dying_while_paused():
			spawn_enemy()
			return
		else:
			return
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
	
func spawn_hourglass() -> void:
	var hourglass = HOURGLASS.instantiate()
	add_child(hourglass)
	hourglass.global_position = Vector2(400,400)
	print("hourglass spawned")
	
func hide_upgrades() -> void:
	cards.get_node("Control").hide()

## private methods

func _has_enemy_child() -> bool:
	for child in get_children():
		if child.is_in_group("enemy"):
			return true
	return false
	
func _is_enemy_dying_while_paused() -> bool:
	for child in get_children():
		if child.is_in_group("enemy"):
			if child.health_bar.health <= 0.0:
				print("Enemy is dying while paused, try to spawn again")
				return true
	print("Enemy is not dying while paused, return")
	return false
