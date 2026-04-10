extends Node
## enums
## consts
## exports
## public vars
## private vars
## onready vars
@onready var color_rect: ColorRect = $ColorRect

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if GlobalStats.dragging_minion == true:
		color_rect.visible = true
	else: 
		color_rect.visible = false

## public methods
func sell_minion(_target : Node2D) -> void:
	Audio.minion_death()
	print("Vendiste al minion")

## private methods
