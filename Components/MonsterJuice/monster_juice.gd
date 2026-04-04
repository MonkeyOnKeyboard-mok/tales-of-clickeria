extends Node
class_name JuiceBar
## enums
## consts
## exports
## public vars
var max_juice : float = 1000.0 : set = set_max_juice
var juice : float: set = set_juice, get = get_juice
var min_juice : float = 0.0
var _juice := 0.0
var _max_juice := 1000.0
var initialized := false
## private vars
## onready vars
@onready var label: Label = $Label
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	Event.gain_juice.connect(gain_juice)
	juice = 0.0
	self.value = _juice
	label.text = str(int(self.value))
	initialized = true

func _process(_delta: float) -> void:
	pass

## public methods

func set_max_juice(new_value: float) -> void:
	print("MAX juice CHANGED:", new_value)
	var difference := new_value - _max_juice
	_max_juice = new_value
	self.max_value = _max_juice
	juice += difference

func set_juice(new_juice: float) -> void:
	#if new_health < health:
		#%HappyBooSkin.hurt()
	_juice = clamp(new_juice, 0.0, _max_juice)
	if not initialized:
		self.value = _juice
		return
	var tween := create_tween().set_parallel()
	tween.tween_property(self, "value", _juice, 0.3)
	label.text = str(int(self.value))

func get_juice() -> float:
	return _juice

func spend_juice(juice_spent : float) -> void:
	if juice_spent <= juice:
		juice -= juice_spent
		Event.emit_signal("player_gained_health", 5.0)
		print("You bought a health potion")
	else : print("You don't have enough juice!")

func gain_juice(juice_gained: float) -> void:
	juice += juice_gained

## private methods
