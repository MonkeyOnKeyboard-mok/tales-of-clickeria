extends Node2D
## enums
## consts
const ENEMY_STUN = preload("uid://mirwsmveystf")
## exports
## public vars
var cone : Node2D = null
## private vars
var _rotating : bool = true
var time : float = 0.0
var speed :float = 2.0     # controls how fast it oscillates
var max_angle : float = 55.0
## onready vars
@onready var stun_timer: Timer = $StunTimer
@onready var start_timer: Timer = $StartTimer
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	_start_timer()

func _process(_delta: float) -> void:
	if _rotating:
		time += _delta * speed
		rotation_degrees = sin(time) * max_angle

## public methods

func stun_attack() -> void:
	var stun = ENEMY_STUN.instantiate()
	_rotating = true
	add_child(stun)
	cone = stun

func stun_stop() -> void:
	_rotating = false
	if !cone: return
	cone.attack()   ## Crashed
	print("Stun place selected")

## private methods
func _stun_timer() -> void:
	var value = randf_range(3.0, 6.0)
	stun_timer.start(value)
	print("Stun timer initiated")

func _start_timer() -> void:
	var value = randf_range(1.0, 3.0)
	start_timer.start(value)
	print("Start timer initiated")

func _on_start_timer_timeout() -> void:
	stun_attack()
	_stun_timer()
	print("Stun attack function")

func _on_stun_timer_timeout() -> void:
	stun_stop()
	start_timer.start(5.0)
	print("Start timer initiated again")
