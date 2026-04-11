extends Node
class_name MinionManager
## enums
## consts
## exports
## public vars
## private vars
## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	Event.spell_echo_selection.connect(spell_echo_selection)
	Event.spell_echo_selected.connect(spell_echo_selected)
func _process(_delta: float) -> void:
	pass

## public methods
func set_new_target(enemy: Node2D) -> void:   ## El target de los minions se settea cuando spawnea un enemigo
	for child in get_children():
		if child is Node2D:
			child.new_target(enemy)
			#print("minion new target set")

func spell_echo_selection() -> void:
	print("Pick a unit to apply Spell Echo to")
	for child in get_children():
		if child is Node2D:
			child.glow()

func spell_echo_selected() -> void:
	print("Spell Echo Applied")
	for child in get_children():
		if child is Node2D:
			child.unglow()

## private methods
