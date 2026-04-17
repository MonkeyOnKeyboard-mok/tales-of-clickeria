extends Node
class_name PlayerHealthBar
## enums
## consts
## exports
@export var top_y: float = -103.0     # full HP position
@export var bottom_y: float = 85.0 # empty HP position
@onready var player_health2 : Label = get_node("/root/Main/Player/PlayerHealth")

## public vars
var max_health : float = 100.0 : set = set_max_health
var health : float: set = set_health, get = get_health
var min_health : float = 0.0
var _health := 0.0
var _max_health := 100.0
var initialized := false
## private vars
## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	max_health = 100.0
	health = max_health
	self.value = _health
	initialized = true

func _process(_delta: float) -> void:
	_funcion_ro()

## public methods

func set_max_health(new_value: float) -> void:
	#print("MAX HEALTH CHANGED:", new_value)
	var difference := new_value - _max_health
	_max_health = new_value
	self.max_value = _max_health
	health += difference

func set_health(new_health: float) -> void:
	#if new_health < health:
		#%HappyBooSkin.hurt()
	_health = clamp(new_health, 0.0, _max_health)
	if not initialized:
		self.value = _health
		return
	var tween := create_tween().set_parallel()
	tween.tween_property(self, "value", _health, 0.3)
	tween.tween_method(
		func(value): player_health2.text = "Health: " + str(round(value)),
		self.value, _health, 0.3
	)

func get_health() -> float:
	return _health

func take_damage(damage : float) -> void:
	health -= damage
	if health < 1.0:
		Event.emit_signal("player_died")

func gain_health(health_gained: float) -> void:
	health += health_gained

## private methods
func _funcion_ro() -> void:
	if _health < 92:
		$Mask/Bar_top.visible = true
	var ratio: float = clamp(_health / _max_health, 0.0, 1.0)
	# Interpolate between empty and full
	var y_pos: float = lerp(bottom_y, top_y, ratio)
	$Mask/Bar_top.position.y = y_pos 
