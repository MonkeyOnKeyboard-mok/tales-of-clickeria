extends Node

## Debuggin Variables
var debugging : Dictionary = {
	"level" : false
}

## Player Variables
var playerStats : Dictionary = {}

###### Minion Variables ######
var minionStats : Dictionary = {}
var minion_counter : int = 0
var dragging_minion : bool = false

func _ready() -> void:
	reset_stats()

func _process(_delta: float) -> void:
	pass

func reset_stats() -> void:
	playerStats  = {
	"level" : 1,
	"can_level_up" : false,
	"main_attack" : 1.0,
	"main_attack_juice" : 1.0,
	"can_buy" : false,
	"juice" : 0.0
}
	minionStats  = {
	"flat_damage" :{
		"fire" : 0.0,
		"cold" : 0.0,
		"light": 0.0,
		"earth": 0.0,
		"global": 0.0
	},
	"increased_damage" :{
		"fire" : 1.0,
		"cold" : 1.0,
		"light": 1.0,
		"earth": 1.0,
		"global": 1.0
	},
	"attack_speed" :{
		"fire" : 0.0,
		"cold" : 0.0,
		"light": 0.0,
		"earth": 0.0,
		"global": 0.0
	},
	"harvest" : {
		"minion_harvest" : 1.0
	} 
}
