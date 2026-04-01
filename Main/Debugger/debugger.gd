extends Node
## enums
## consts
const FIRE = preload("uid://c6758l4ovsyf1")
const LIGHT = preload("uid://bg5nnqgeloj4y")

## exports
## public vars
## private vars
var min_types : Array = []
## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	min_types  = [FIRE, LIGHT]

func _process(_delta: float) -> void:
	pass

## public methods

## private methods

func _on_button_pressed() -> void:
	get_parent().spawn_enemy()

func _on_minion_spawner_pressed() -> void:
	get_parent().spawn_minion(min_types.pick_random())
