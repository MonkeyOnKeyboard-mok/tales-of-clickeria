extends Node
## enums
## consts
const AGUA = preload("uid://21mccb62av4s")
const SCREAM_1 = preload("uid://l7ug70ai0nyy")
const SCREAM_2 = preload("uid://b4s4hwghwspic")
const SCREAM_3 = preload("uid://cpowua8nhgysl")
const SCREAM_4 = preload("uid://dgio02pqsfbt")
const SCREAM_5 = preload("uid://cmqvpm8jkasym")
const BLENDER = preload("uid://c65kifu2qrr74")
const ANUNCIO_ETAPA = preload("uid://brw8brkgjovbb")
const ANUNCIO_LEVEL_UP = preload("uid://cnt56i3opd8pm")
const CLICK = preload("uid://bt42hef85u0vo")
const COMPRA = preload("uid://dgm8268u6j3vg")
const GORILA_APARECE = preload("uid://bxfjqkxia88c2")
const POCIÓN = preload("uid://cjeohfuiqdac5")
## exports
## public vars
## private vars
var screams : Array = []
var scream_counter : int = 0
## onready vars
@onready var main_loop: AudioStreamPlayer = $main_loop
@onready var cold_attack: AudioStreamPlayer = $cold_attack
@onready var blender: AudioStreamPlayer = $blender
@onready var menu: AudioStreamPlayer = $menu

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	screams = [SCREAM_1, SCREAM_2, SCREAM_3, SCREAM_4, SCREAM_5]

func _process(_delta: float) -> void:
	pass

## public methods
func main_menu() -> void:
	menu.play()

func menu_out() -> void:
	var tween = create_tween()
	tween.tween_property(menu, "volume_db", -45 , 2.0)
	tween.tween_callback(func ll(): 
		menu.stop() 
		menu.volume_db = -14.133)

func main_loop_out() -> void:
	var tween = create_tween()
	tween.tween_property(main_loop, "volume_db", -45 , 2.0)
	tween.tween_callback(func ll(): 
		main_loop.stop() 
		main_loop.volume_db = -14.133)

func cold_attacks() -> void:
	cold_attack.play()

func minion_death() -> void:
	blender.play()
	if scream_counter == 4:
		scream_counter = 0
	var player = AudioStreamPlayer.new()
	player.stream = screams[scream_counter]
	add_child(player)
	player.play()
	scream_counter += 1
	player.finished.connect(player.queue_free)

func click() -> void:
	var player = AudioStreamPlayer.new()
	player.stream = CLICK
	add_child(player)
	player.volume_db = -13.066
	player.play()
	player.finished.connect(player.queue_free)

func compra() -> void:
	var player = AudioStreamPlayer.new()
	player.stream = COMPRA
	add_child(player)
	player.volume_db = -13.066
	player.play()
	player.finished.connect(player.queue_free)

func can_level_up() -> void:
	var player = AudioStreamPlayer.new()
	player.stream = ANUNCIO_LEVEL_UP
	add_child(player)
	player.volume_db = -13.066
	player.play()
	player.finished.connect(player.queue_free)

func can_zone_up() -> void:
	var player = AudioStreamPlayer.new()
	player.stream = ANUNCIO_ETAPA
	add_child(player)
	player.volume_db = -13.066
	player.play()
	player.finished.connect(player.queue_free)

## private methods
