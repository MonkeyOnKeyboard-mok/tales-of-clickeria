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


## exports
## public vars
## private vars
var screams : Array = []
var scream_counter : int = 0
## onready vars
@onready var main_loop: AudioStreamPlayer = $main_loop
@onready var cold_attack: AudioStreamPlayer = $cold_attack
@onready var blender: AudioStreamPlayer = $blender

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	screams = [SCREAM_1, SCREAM_2, SCREAM_3, SCREAM_4, SCREAM_5]
	main_loop.play()

func _process(_delta: float) -> void:
	pass

## public methods

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

## private methods
