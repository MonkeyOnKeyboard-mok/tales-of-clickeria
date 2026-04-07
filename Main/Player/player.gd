extends Node
## enums
## consts
## exports
## public vars
## private vars
## onready vars
@onready var player_health: Label = $PlayerHealth
@onready var lifeBar: PlayerHealthBar = $ProgressBar
@onready var juiceBar: ProgressBar = %MonsterJuice
@onready var expBar: ExpBar = %ExpBar
@onready var player_lvl: Label = $PlayerLvl

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	Event.player_gained_health.connect(lifeBar.gain_health)
	Event.spent_juice.connect(juiceBar.spend_juice)
	player_health.text = "Player Health"

func _process(_delta: float) -> void:
	player_lvl.text = "Player Level: " + str(expBar.current_level)

func recibir_ataque_enemigo(dano):
	lifeBar.take_damage(dano)

## private methods
