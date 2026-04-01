extends Node

## Player Variables
var playerStats : Dictionary = {
	"main_attack" : 1.0
}

###### Minion Variables ######
var minionStats : Dictionary = {
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
	}
}

func _ready() -> void:
	reset_stats()

func _process(_delta: float) -> void:
	pass

func reset_stats() -> void:
	playerStats = {
	"main_attack" : 1.0
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
	}
}
