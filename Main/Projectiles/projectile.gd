extends Node
## enums
## consts
## exports
## public vars
var direction := Vector2.ZERO
var speed : float = 200
var spawnRot : float
var enemy : Node2D = null
## private vars
## onready vars
@onready var parent = get_parent().get_parent()
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var self_destruct: Timer = $SelfDestruct

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
		area.get_parent().health_bar.take_damage(parent.calculate_damage())
		queue_free()

func _on_self_destruct_timeout() -> void:
	queue_free()
