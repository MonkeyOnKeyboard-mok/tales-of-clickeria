extends Node
## enums
## consts
## exports
## public vars
## private vars
## onready vars
@onready var level_up_rect: ColorRect = $LevelUp/LevelUpRect

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if GlobalStats.playerStats["can_level_up"] == true:
		level_up_rect.visible = true
	else:
		level_up_rect.visible = false

## public methods

## private methods

func _on_button_pressed() -> void:
	Event.emit_signal("spawn_enemy")

func _on_minion_spawner_pressed() -> void:
	Event.emit_signal("spawn_minion", Event.MINION_TYPES.values().pick_random())

func _on_hourglas_spawner_pressed() -> void:
	Event.emit_signal("spawn_hourglass")

func _on_level_up_pressed() -> void:
	if GlobalStats.debugging["level"] == true or GlobalStats.playerStats["can_level_up"] == true:
		Event.emit_signal("player_leveled_up")

func _on_by_pass_pressed() -> void:
	GlobalStats.debugging["level"] = !GlobalStats.debugging["level"]
	#print(GlobalStats.debugging["level"])

func _on_pause_pressed() -> void:
	Event.emit_signal("pause_game")

func _on_gain_juice_pressed() -> void:
	Event.emit_signal("gain_juice", 10000.0)

func _on_trigger_boss_pressed() -> void:
	GestorEtapa.etapa_actual = 8
	GestorEtapa.kill_count = 0
