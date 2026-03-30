extends Node
## enums
## consts
## exports
## public vars
var direction := Vector2.ZERO
var speed : float = 200
var spawnRot : float
var enemy : Node2D = null
#var dmg : float = get_parent().get_parent().stats.damage
## private vars
## onready vars
@onready var parent = get_parent().get_parent()
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	self.position += direction * speed * _delta

## public methods

## private methods


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().lifeBar.take_damage(parent.stats.base_damage)
		queue_free()
