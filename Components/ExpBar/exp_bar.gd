extends Node
class_name ExpBar
## enums
## consts
## exports
## public vars
var max_exp : float = 30.0 : set = set_max_exp, get = get_max_exp
var xp : float: set = set_exp, get = get_exp
var min_exp : float = 0.0
var _exp := 0.0
var _max_exp := 30.0
var initialized := false
var overflow : float = 0
var current_level : int = 1 
## private vars
## onready vars
@onready var label: Label = $Label
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	Event.gained_experience.connect(gain_exp)
	Event.player_leveled_up.connect(_level_up)
	if not initialized:
		max_exp = 30.0
		xp = 0.0
		label.text = str(int(self.value))+"/"+str(int(_max_exp))
		self.value = _exp
		initialized = true

func _process(_delta: float) -> void:
	pass

## public methods
func set_max_exp(new_value: float) -> void:
	#print("MAX EXP CHANGED:", new_value)
	_max_exp = new_value
	self.max_value = _max_exp

func set_exp(new_exp: float) -> void:
	#if new_health < health:
		#%HappyBooSkin.hurt()
	_exp = clamp(new_exp, 0.0, _max_exp)
	if not initialized:
		self.value = _exp
		return
	var tween := create_tween().set_parallel()
	tween.tween_property(self, "value", _exp, 0.3)
	tween.tween_method(
		func(value): label.text = str(int(self.value))+"/"+str(int(self.max_value)),
		self.value, _exp, 0.3
	)

func get_exp() -> float:
	return _exp
	
func get_max_exp() -> float:
	return _max_exp
	
func gain_exp(gained_exp : float) -> void:
	var total_xp = xp + gained_exp
	if total_xp >= _max_exp:
		overflow += total_xp -_max_exp
		xp = _max_exp
		print("xp is greater max exp, overflow is now:" , overflow)
		GlobalStats.playerStats["can_level_up"] = true
	else:
		xp = total_xp

## private methods
func _level_up() -> void:
	GlobalStats.playerStats["level"] += 1
	xp = overflow
	print("XP is :", xp, "Overflow is:  ", overflow)
	overflow = 0.0
	max_exp = _get_required_xp(GlobalStats.playerStats["level"])
	GlobalStats.playerStats["can_level_up"] = false
	Event.emit_signal("pause_game")
	current_level += 1

func _get_required_xp(level: int) -> float:
	return 30.0 * pow(1.18, level - 1)
