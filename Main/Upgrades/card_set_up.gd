extends Control

var card: Cards

@onready var icon = $Panel/texture
@onready var name_label = $Panel/name
@onready var desc_label = $Panel/desc
@onready var button = $Panel/select

func set_card(new_card: Cards):
	card = new_card
	icon.texture = card.icon
	name_label.text = card.name
	desc_label.text = card.description

func _on_select_pressed() -> void:
	print("Seleccionaste la carta: ", name_label.text)
	GlobalStats.minionStats[card.effect][card.type] += card.value
	print(GlobalStats.minionStats)
	#emit_signal("upgrade_selected",card.type)
	Event.emit_signal("upgrade_chosen")
	Event.emit_signal("update_passives", card.type, card.effect, card.value)
	Event.emit_signal("pause_game")
	queue_free()
