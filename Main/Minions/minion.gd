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
## private vars
## onready vars
@onready var attack : AttackComponent = %AttackScript
@onready var base_attack_speed : float = stats.attack_speed
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	sprite.play("idle")
	#print("Minion type: ", stats.type)
	#print("Minion Atk SPD: ", stats.attack_speed)
	#print("Minion Base DMG: ", stats.base_damage)
	#print("Minion Crit Chance: ", stats.crit_chance)
	calculate_damage()

func _process(_delta: float) -> void:
	if self.global_position.x > 1152.0/2.0:
		sprite.flip_h = false
	else: sprite.flip_h = true

## public methods

func new_target(enemy: Node2D) -> void:
	print("minion target: ", enemy)
	attack.minion_attack(enemy)

func calculate_damage() -> float:
	damage = (((stats.base_damage + gs["flat_damage"][stats.type] + gs["flat_damage"]["global"] ) * gs["increased_damage"][stats.type] ) * gs["increased_damage"]["global"])
	#print("Minion Base Damage: ", stats.base_damage)
	#print("Global Fire Damage Flat:", gs["flat_damage"][stats.type]) 
	#print("Global Fire Damage Increase:", gs["increased_damage"][stats.type])
	#print("This minion's damage is: ", damage) 
	return damage

func apply_attack_speed_buff() -> void:
	print("Attack Speed increased")
	stats.attack_speed *= 0.001
	print("this minion attack speed is: ",stats.attack_speed)

func remove_atk_spd() -> void:
	print("Attack Speed returned to base")
	stats.attack_speed = base_attack_speed
	
###  cambiar para que solo afectea este minion y no al resource

## private methods
