extends Node
## enums
## consts
## exports
@export var stats : UnitStats 
@onready var sprite: AnimatedSprite2D = $Sprite2D
## public vars
var target : Node2D = null
## private vars
## onready vars
@onready var attack : AttackComponent = %AttackScript
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	sprite.play("idle")

func _process(_delta: float) -> void:
	if self.global_position.x > 1152/2:
		sprite.flip_h = false
	else: sprite.flip_h = true

## public methods

func new_target(enemy: Node2D) -> void:
	print("minion target: ", enemy)
	attack.minion_attack(enemy)
	
## private methods
