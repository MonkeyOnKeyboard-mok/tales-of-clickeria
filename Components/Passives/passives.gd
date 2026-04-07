extends Node
## enums
## consts
const PASSIVE_ICON = preload("uid://b22ksnq2ecclr") ## Escena de la pasiva
## Flat Damage:
const FIRE_FLAT = preload("uid://yw4xg2d7uqb")
const COLD_FLAT = preload("uid://i542asnysog5")
const LIGHT_FLAT = preload("uid://bqwxgx37cyr0v")
const GLOBAL_FLAT = preload("uid://c48g5u88323q")

## Increased Damage: 
const FIRE_INCREASED = preload("uid://byrtmfjabcd4g")
const COLD_INCREASED = preload("uid://vskgsfmeibyw")
const LIGHT_INCREASED = preload("uid://5we37crvvjnw")
const GLOBAL_INCREASED = preload("uid://imo3bpbxq4b")

## Harvest: 
const HARVEST_1 = preload("uid://bybnkd7f1e72w")
const HARVEST_2 = preload("uid://1osprvxfy7ib")

## exports
## public vars
var dict : Dictionary = {}
## private vars
## onready vars
@onready var hBox: HBoxContainer = $HBoxContainer
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	dict = {
	"flat_damage" : {
		"fire" : [false, FIRE_FLAT],
		"cold" : [false, COLD_FLAT],
		"light" : [false, LIGHT_FLAT], ##
		"earth" : [false, null], ## REPLACE ONCE IMPLEMENTED
		"global" : [false, GLOBAL_FLAT], ##
	},
	"increased_damage" : {
		"fire" : [false, FIRE_INCREASED],
		"cold" : [false, COLD_INCREASED],
		"light" : [false, LIGHT_INCREASED], ##
		"earth" : [false, null], ## REPLACE ONCE IMPLEMENTED
		"global" : [false, GLOBAL_INCREASED], ##
	},
	"harvest" : {
		"minion_harvest": [false, null], ## REPLACE ONCE IMPLEMENTED 
		"player_harvest" : [false, null], ## REPLACE ONCE IMPLEMENTED
	}
}
	Event.update_passives.connect(update_icons)

func _process(_delta: float) -> void:
	pass

## public methods
func update_icons (type: String, effect : String, _value: float) -> void:
	print("señal recibida")
	if dict[effect][type][0] == true:
		dict[effect][type][2].set_text(effect, type)
		return
	else:
		dict[effect][type][0] = true
		var icon = PASSIVE_ICON.instantiate()
		hBox.add_child(icon)
		icon.set_texture(dict[effect][type][1])
		icon.set_text(effect, type)
		dict[effect][type].append(icon) 
		print(dict)
		
## private methods
