extends Control

var card: Cards

@onready var icon: TextureButton = $Panel/select
@onready var name_label = $Panel/name
@onready var desc_label = $Panel/desc
@onready var color_rect: TextureRect = $Panel/ColorRect

func set_card(new_card: Cards):
	card = new_card
	color_rect.texture = card.art
	icon.texture_normal = card.icon
	icon.texture_hover = card.hover
	name_label.text = card.name
	desc_label.text = card.description

func _on_select_pressed() -> void:
	if card.effect == "item": 
		_item_card_selected()
		return
	print("Seleccionaste la carta: ", name_label.text)
	GlobalStats.minionStats[card.effect][card.type] += card.value
	print(GlobalStats.minionStats)
	#emit_signal("upgrade_selected",card.type)
	Event.emit_signal("upgrade_chosen")
	Event.emit_signal("update_passives", card.type, card.effect, card.value)
	Event.emit_signal("pause_game")
	queue_free()

func _item_card_selected()  -> void:
	print("Elegiste una carta que es un item ")
	Event.emit_signal("upgrade_chosen")
	Event.emit_signal("spell_echo_selection")
	Event.spell_echo_sel_on = true
	queue_free()
