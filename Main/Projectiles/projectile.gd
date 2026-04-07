extends Node
## enums
## consts
## exports
## public vars
var direction := Vector2.ZERO
var speed : float = 300.0
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
	if area.is_in_group("jugador"):
		if is_in_group("player_projectile"): return
		area.get_parent().lifeBar.take_damage(GestorEtapa.projectile_damage)
		queue_free()
	if area.is_in_group("enemy"):
		if is_in_group("enemy_projectile"): return
		area.get_parent().health_bar.take_damage(parent.calculate_damage())
		Event.emit_signal("spawn_particle",self.global_position)
		Event.emit_signal("gain_juice",(parent.calculate_damage()))
		queue_free()
	if is_in_group("player_projectile") and area.get_parent().is_in_group("enemy_projectile"):
		area.get_parent().queue_free()
		queue_free()

func _on_self_destruct_timeout() -> void:
	queue_free()

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if is_in_group("enemy_projectile"):
		if event is InputEventMouseButton and event.pressed:
			queue_free()
