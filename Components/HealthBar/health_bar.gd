extends Node
class_name HealthBar
## enums
## consts
## exports
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
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	initialized = true

func _process(_delta: float) -> void:
	pass

## public methods

func set_max_health(new_value: float) -> void:
	print("MAX HEALTH CHANGED:", new_value)
	var difference := new_value - _max_health
	_max_health = new_value
	self.max_value = _max_health
	health += difference

func set_health(new_health: float) -> void:
	#if new_health < health:
		#%HappyBooSkin.hurt()
	
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
	print("Damage:", damage)
	print("Before:", health)
	health -= damage
	label.text = str(int(health))
	if health < 1.0:
		get_parent().get_parent().enemy_died()
		get_parent().queue_free()
	print("After:", health)


## private methods
