extends Node
class_name HealthBar
## enums
## consts
## exports
## public vars
var max_health : int = 100
var health : int 
var min_health : int = 0
## private vars
## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	#max_health = max_health * global.level_difficulty
	health = max_health
	self.value = health

func _process(_delta: float) -> void:
	pass

## public methods

func take_damage(damage : int) -> void:
	health -= damage
	self.value = health

## private methods
