extends Node
## enums
## consts
const AGUA = preload("uid://21mccb62av4s")
## exports
## public vars
## private vars
## onready vars
@onready var main_loop: AudioStreamPlayer = $main_loop
@onready var cold_attack: AudioStreamPlayer = $cold_attack
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	main_loop.play()

func _process(_delta: float) -> void:
	pass

## public methods

func cold_attacks() -> void:
	cold_attack.play()

## private methods
