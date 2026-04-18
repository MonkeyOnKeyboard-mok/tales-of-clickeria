extends Node
class_name HealthBar
## enums
## consts
## exports
@export var top_y: float = -83.0     # full HP position
@export var bottom_y: float = 100.0 # empty HP position
## public vars
var max_health : float  : set = set_max_health
var health : float: set = set_health, get = get_health
var min_health : float = 0.0
var _health : float
var _max_health : float
var initialized := false
## private vars
## onready vars
@onready var label: Label = $Label
@onready var bar_top: AnimatedSprite2D = $Bar_top

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	initialized = true
	self.value =  40.0

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
	
	_health = clamp(new_health, 0.0, _max_health)
	label.text = str(int(health))
	if not initialized:
		self.value = _health
		return
	var tween := create_tween().set_parallel()
	tween.tween_property(self, "value", _health, 0.3)


func get_health() -> float:
	return _health

func take_damage(damage : float) -> void:
	if get_parent().dying == true: return
	#print("Damage:", damage)
	#print("Before:", health)
	health -= damage
	label.text = str(int(health))
	if health < 1.0:
		get_parent().dying = true
		Event.emit_signal("gained_experience", get_parent().level_component.exp_granted)
		#print("Enemy granted :", get_parent().level_component.exp_granted, "exp")
		get_parent()._death_animation()
	#print("After:", health)

## private methods
func _funcion_ro() -> void:
	print("_health =", _health)
	if _health < 92:
		bar_top.visible = true
		print("vida es menos que 92")
	var ratio: float = clamp(self.value / _max_health, 0.0, 1.0)
	# Interpolate between empty and full
	var y_pos: float = lerp(bottom_y, top_y, ratio)
	bar_top.position.y = y_pos
