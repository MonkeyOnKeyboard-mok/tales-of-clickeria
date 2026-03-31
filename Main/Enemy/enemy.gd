extends Node
## enums
## consts
## exports
## public vars
## private vars
## onready vars
@onready var lifeBar : HealthBar = %HealthBar
@onready var attack : EnemyAttack = %EnemyAttack
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	attack.enemy_attacked.connect(_on_enemy_attack)

func _process(_delta: float) -> void:
	pass

## public methods


## private methods

func _on_enemy_attack() -> void:
	print("enemy attacked")
	get_parent().player.lifeBar.take_damage(attack.stats.base_damage)

func _on_area_2d_input_event(_viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		lifeBar.take_damage(100)
