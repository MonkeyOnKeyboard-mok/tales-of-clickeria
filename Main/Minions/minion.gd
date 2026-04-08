extends Node
## enums
## consts
## exports
@export var stats : UnitStats 


## public vars
var target : Node2D = null
var gs : Dictionary = GlobalStats.minionStats

## Animation Variables
var attack_anim : String 
var idle_anim : String 

## private vars
var personal_damage : float = 0.0
var current_attack_speed : float 
var damage : float 
var level : int = 1
var multiplier : float = 1.0
var level_up_cost : float = 60.0

## onready vars
@onready var attack : AttackComponent = %AttackScript
@onready var base_attack_speed : float = stats.attack_speed
## Sprites:
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var floor_halo: TextureRect = $Sprite2D/floor_halo
@onready var hourglass_halo: TextureRect = $Sprite2D/hourglass_halo
@onready var level_up_halo: TextureRect = $Sprite2D/level_up_halo

@onready var tooltip: Panel = $Tooltip
@onready var dragg_and_drop: DragAndDrop = $DraggAndDrop

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	dragg_and_drop.show_tooltip.connect(_show_tooltip)
	_set_textures()
	sprite.play(idle_anim)
	current_attack_speed = stats.attack_speed
	calculate_damage()
	var enemy = get_tree().get_nodes_in_group("enemy")
	#print("Enemy is :",enemy)
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
	#print("Minion target: ", enemy)
	attack.set_target(enemy)

func calculate_damage() -> float:
	damage = (((stats.base_damage + gs["flat_damage"][stats.type] + gs["flat_damage"]["global"]) + personal_damage \
	* gs["increased_damage"][stats.type] ) * gs["increased_damage"]["global"])
	#print("Minion Base Damage: ", stats.base_damage)
	#print("Global Fire Damage Flat:", gs["flat_damage"][stats.type]) 
	#print("Global Fire Damage Increase:", gs["increased_damage"][stats.type])
	#print("This minion's damage is: ", damage) 
	#print(damage)
	return damage

func apply_attack_speed_buff() -> void:
	hourglass_halo.visible = true
	current_attack_speed *= 0.1
	sprite.speed_scale += 1.0

func remove_atk_spd() -> void:
	hourglass_halo.visible = false
	current_attack_speed = stats.attack_speed
	sprite.speed_scale = 1.0

func glow() -> void:
	level_up_halo.visible = true
	
func unglow() -> void:
	level_up_halo.visible = false
	
func level_up() -> void:
	if level_up_cost > GlobalStats.playerStats["juice"]: 
		print("Not enough jucie to level up")
		return
	level += 1
	personal_damage += 6 * multiplier
	multiplier += 0.1
	Event.emit_signal("spent_juice", level_up_cost)
	level_up_cost *= 2.0
	print("Minion leveled up")
	
## private methods

func _show_tooltip() -> void:
	tooltip.show()

func _set_textures() -> void:
	match stats.type:
		"fire":
			attack_anim = "attack_fire"
			idle_anim = "idle_fire"
		"light":
			attack_anim = "attack_light"
			idle_anim = "idle_light"
		"cold":
			attack_anim = "attack_cold"
			idle_anim = "idle_cold"
