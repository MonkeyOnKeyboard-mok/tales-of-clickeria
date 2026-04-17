extends Node
## enums
## consts
## exports
## public vars
var dying : bool = false
var stunned_state : bool = false

## Animation Variables
var attack_anim : String 
var idle_anim : String 

## private vars
var personal_damage : float = 0.0
var damage : float 
var level : int = 1
var multiplier : float = 1.0
var level_up_cost : float = 60.0

## onready vars
@onready var area_2d: Area2D = $Area2D
@onready var shape: CollisionShape2D = $Area2D/CollisionShape2D
## Sprites:
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var dragg_and_drop: DragAndDrop = $DraggAndDrop
@onready var heal_timer: Timer = $heal
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	_set_textures()
	calculate_damage()
	heal_timer.start()

func _process(_delta: float) -> void:
	if self.global_position.x > 1152.0/2.0:
		sprite.flip_h = false
	else: sprite.flip_h = true

## public methods

func calculate_damage() -> float:
	damage = 5.0
	return damage

func level_up() -> void:
	if level_up_cost > GlobalStats.playerStats["juice"]: 
		print("Not enough jucie to level up")
		return
	level += 1
	personal_damage += 6 * multiplier
	multiplier += 0.1
	Event.emit_signal("spent_juice", level_up_cost)
	level_up_cost *= 2.0
	print("Minion leveled up")

func try_sell() -> void:
	var overlap = area_2d.get_overlapping_areas()
	for o in overlap:
		if o.is_in_group("blender"):
			o.get_parent().sell_minion(self)
			_die()
			dying = true

func stunned()-> void:
	sprite.stop()
	heal_timer.stop()
	stunned_state = true
	var stun_tween = create_tween()
	stun_tween.tween_property(sprite, "modulate",Color(0.373, 0.373, 0.373, 0.596), 0.5)
	await get_tree().create_timer(2.0).timeout
	var stun_tween2 = create_tween()
	stun_tween2.tween_property(sprite, "modulate",Color(1.0, 1.0, 1.0), 0.5)
	stunned_state = false
	#print("Enemy is :",enemy)
	heal_timer.start()

func push_back() -> void:
	var push_tween = create_tween()
	push_tween.tween_property(self, "global_position" , Vector2(575,480),0.2)

func heal() -> void:
	sprite.play("default")
	Event.emit_signal("player_gained_health", 1.0)


## private methods

func _set_textures() -> void:
	pass ## Use

func _die()-> void:
	var skew_tween = create_tween()
	var rot_tween = create_tween()
	var small_tween = create_tween()
	small_tween.tween_property(self, "scale", Vector2(0.001, 0.001), 1.5)
	skew_tween.tween_property(self, "skew", 86.0, 1.0)
	rot_tween.tween_property(self, "rotation_degrees", 360, 1.0)
	rot_tween.set_loops()  # keeps repeating
	Event.emit_signal("gain_juice", (level * calculate_damage()))
	Event.emit_signal("spawn_particle", self.global_position)
	small_tween.tween_callback(Callable(self,"queue_free"))

func _on_heal_timeout() -> void:
	heal()
	heal_timer.start()
