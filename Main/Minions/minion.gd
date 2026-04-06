extends Node
## enums
## consts
## exports
@export var stats : UnitStats 
@onready var sprite: AnimatedSprite2D = $Sprite2D
## public vars
var target : Node2D = null
var damage : float 
var gs : Dictionary = GlobalStats.minionStats
var current_attack_speed : float 
## private vars
## onready vars
@onready var attack : AttackComponent = %AttackScript
@onready var base_attack_speed : float = stats.attack_speed

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	print("MINION SPAWNEO EN: ", self.global_position)
	sprite.play("idle")
	current_attack_speed = stats.attack_speed
	calculate_damage()
	var enemy = get_tree().get_nodes_in_group("enemy")
	print("Enemy is :",enemy)
	if enemy.size() > 0:
		new_target(enemy[0])
	#print("spawned minion attack speed is:", current_attack_speed)
	#print("Minion type: ", stats.type)
	#print("Minion Atk SPD: ", stats.attack_speed)
	#print("Minion Base DMG: ", stats.base_damage)
	#print("Minion Crit Chance: ", stats.crit_chance)
	

func _process(_delta: float) -> void:
	if self.global_position.x > 1152.0/2.0:
		sprite.flip_h = false
	else: sprite.flip_h = true

## public methods

func new_target(enemy: Node2D) -> void:
	print("Minion target: ", enemy)
	attack.set_target(enemy)

func calculate_damage() -> float:
	damage = (((stats.base_damage + gs["flat_damage"][stats.type] + gs["flat_damage"]["global"] ) * gs["increased_damage"][stats.type] ) * gs["increased_damage"]["global"])
	#print("Minion Base Damage: ", stats.base_damage)
	#print("Global Fire Damage Flat:", gs["flat_damage"][stats.type]) 
	#print("Global Fire Damage Increase:", gs["increased_damage"][stats.type])
	#print("This minion's damage is: ", damage) 
	print(damage)
	return damage

func apply_attack_speed_buff() -> void:
	current_attack_speed *= 0.1
	sprite.speed_scale += 1.0

func remove_atk_spd() -> void:
	current_attack_speed = stats.attack_speed
	sprite.speed_scale = 1.0
	
###  cambiar para que solo afectea este minion y no al resource

## private methods
