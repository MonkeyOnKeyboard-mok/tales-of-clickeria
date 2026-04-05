extends Node
## enums
## consts
## exports
## public vars
## private vars
## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

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
