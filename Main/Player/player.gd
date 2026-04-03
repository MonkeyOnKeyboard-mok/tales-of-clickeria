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

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	player_health.text = "Player Health"

func _process(_delta: float) -> void:
	pass

func recibir_ataque_enemigo(dano):
	lifeBar.take_damage(dano)

## private methods
