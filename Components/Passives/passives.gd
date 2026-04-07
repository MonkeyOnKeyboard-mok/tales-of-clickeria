extends Node
## enums
## consts
const PASSIVE_ICON = preload("uid://b22ksnq2ecclr")
const FLAME = preload("uid://yaa2k253dsbt")

## exports
## public vars
## private vars
## onready vars
@onready var hBox: HBoxContainer = $HBoxContainer
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	Event.update_passives.connect(update_icons)

func _process(_delta: float) -> void:
	pass

## public methods
func update_icons (type: String, effect : String, _value: float) -> void:
	print("señal recibida")
	if type == "fire" and effect == "flat_damage":
		var icon = PASSIVE_ICON.instantiate()
		hBox.add_child(icon)
		icon.set_texture(FLAME)


## private methods
func _add_icon (texture: Texture2D) -> void:
	pass
