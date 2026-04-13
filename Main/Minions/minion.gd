extends Node
## enums
## consts
## exports
@export var stats : UnitStats 


## public vars
var target : Node2D = null
var gs : Dictionary = GlobalStats.minionStats
var buffed : bool = false
var buff_owner : Node = null
var dying : bool = false
var enhance_target : Node = null
var stunned_state : bool = false

## Animation Variables
var attack_anim : String 
var idle_anim : String 

## private vars
var personal_damage : float = 0.0
var current_attack_speed : float 
var damage : float 
var level : int = 1
var multiplier : float = 1.0
var level_up_cost : float = 60.0

## onready vars
@onready var attack : AttackComponent = %AttackScript
@onready var base_attack_speed : float = stats.attack_speed
@onready var area_2d: Area2D = $Area2D
@onready var shape: CollisionShape2D = $Area2D/CollisionShape2D

## Sprites:

@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var floor_halo: TextureRect = $Sprite2D/floor_halo
@onready var hourglass_halo: TextureRect = $Sprite2D/hourglass_halo
@onready var level_up_halo: TextureRect = $Sprite2D/level_up_halo


@onready var tooltip: Panel = $Tooltip
@onready var dragg_and_drop: DragAndDrop = $DraggAndDrop

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	dragg_and_drop.show_tooltip.connect(_show_tooltip)
	_set_textures()
	sprite.play(idle_anim)
	current_attack_speed = stats.attack_speed
	calculate_damage()
	var enemy = get_tree().get_nodes_in_group("enemy")
	#print("Enemy is :",enemy)
	if enemy.size() > 0:
		new_target(enemy[0])
	#print("spawned minion attack speed is:", current_attack_speed)
	#print("Minion type: ", stats.type)
	#print("Minion Atk SPD: ", stats.attack_speed)
	#print("Minion Base DMG: ", stats.base_damage)
	#print("Minion Crit Chance: ", stats.crit_chance)


func _process(_delta: float) -> void:
	if self.global_position.x > 1152.0/2.0:
		sprite.flip_h = false
	else: sprite.flip_h = true

## public methods

func new_target(enemy: Node2D) -> void:
	attack.set_target(enemy)

func calculate_damage() -> float:
	damage = ((((stats.base_damage + gs["flat_damage"][stats.type] + gs["flat_damage"]["global"]) + personal_damage) \
	* gs["increased_damage"][stats.type] ) * gs["increased_damage"]["global"])
	return damage

func apply_attack_speed_buff() -> void:
	hourglass_halo.visible = true
	current_attack_speed *= 0.1
	sprite.speed_scale += 1.0

func remove_atk_spd() -> void:
	hourglass_halo.visible = false
	current_attack_speed = stats.attack_speed
	sprite.speed_scale = 1.0

func glow() -> void:
	level_up_halo.visible = true

func unglow() -> void:
	level_up_halo.visible = false

func buff(_owner: Node) -> void:
	## Duplicating Halo and Gradient
	# Duplicate the texture deeply (including gradient)
	var grad_tex := (floor_halo.texture as GradientTexture2D).duplicate(true)
	floor_halo.texture = grad_tex
	# Now each minion has its own gradient copy
	grad_tex.gradient.set_color(1, _owner.buff_color)
	floor_halo.visible = true
	## Apply Buff
	personal_damage += _owner.buff_value
	
func unbuff(_owner: Node) -> void:
	floor_halo.visible = false
	personal_damage -= _owner.buff_value

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
	stunned_state = true
	var stun_tween = create_tween()
	stun_tween.tween_property(sprite, "modulate",Color(0.373, 0.373, 0.373, 0.596), 0.5)
	await get_tree().create_timer(2.0).timeout
	var stun_tween2 = create_tween()
	stun_tween2.tween_property(sprite, "modulate",Color(1.0, 1.0, 1.0), 0.5)
	stunned_state = false
	var enemy = get_tree().get_nodes_in_group("enemy")
	#print("Enemy is :",enemy)
	if enemy.size() > 0:
		new_target(enemy[0])

## private methods

func _show_tooltip() -> void:
	tooltip.show()

func _set_textures() -> void:
	match stats.type:
		"fire":
			attack_anim = "attack_fire"
			idle_anim = "idle_fire"
		"light":
			attack_anim = "attack_light"
			idle_anim = "idle_light"
		"cold":
			attack_anim = "attack_cold"
			idle_anim = "idle_cold"


func _on_area_2d_area_entered(area: Area2D) -> void:
	if !area.is_in_group("cuadrante"): return
	if area.get_parent().on == false: return
	if buffed : return
	if buff_owner == null and area.get_parent().target == null:
		buff_owner = area.get_parent()
		if buff_owner.check_if_owned(): return
		buff_owner.target = self
		buff(buff_owner)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if !area.is_in_group("cuadrante"): return
	if area.get_parent().on == false: return
	if buff_owner == area.get_parent():
		unbuff(buff_owner)
		buff_owner.target = null
		buff_owner = null

func _die()-> void:
	var skew_tween = create_tween()
	var rot_tween = create_tween()
	var small_tween = create_tween()
	small_tween.tween_property(self, "scale", Vector2(0.001, 0.001), 1.5)
	skew_tween.tween_property(self, "skew", 86.0, 1.0)
	rot_tween.tween_property(self, "rotation_degrees", 360, 1.0)
	rot_tween.set_loops()  # keeps repeating
	GlobalStats.minion_counter -= 1
	Event.emit_signal("gain_juice", (level * calculate_damage()))
	Event.emit_signal("spawn_particle", self.global_position)
	small_tween.tween_callback(Callable(self,"queue_free"))

func _input(event: InputEvent) -> void:
	if enhance_target == null: return
	if get_tree().paused and Event.spell_echo_sel_on:
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			Event.emit_signal("pause_game")
			attack.spell_echo = true
			Event.spell_echo_sel_on = false
			Event.emit_signal("spell_echo_selected")

func _on_area_2d_mouse_entered() -> void:
	if get_tree().paused and Event.spell_echo_sel_on:
		enhance_target = self

func _on_area_2d_mouse_exited() -> void:
	if get_tree().paused and Event.spell_echo_sel_on:
		enhance_target = null
