extends Control

var card: Cards

signal upgrade_selected(type: String)

@onready var icon = $Panel/texture
@onready var name_label = $Panel/name
@onready var desc_label = $Panel/desc
@onready var button = $Panel/select

func set_card(new_card: Cards):
	card = new_card
	icon.texture = card.icon
	name_label.text = card.name
	desc_label.text = card.description

func _on_button_pressed() -> void:
	#match upgrade.effect:
		#"damage":
				#Global.playerBaseDamage += upgrade.value
		#"armor":
				#Global.playerBaseArmor -= 0.1
		#"attack.speed":
				#Global.attackCooldown -= 0.2
	pass

func _on_select_pressed() -> void:
	print("Seleccionaste la carta: ", name_label.text)
	GlobalStats.minionStats[card.effect][card.type] += card.value
	print(GlobalStats.minionStats)
	#emit_signal("upgrade_selected",card.type)
	get_parent().get_parent().hide()  # hides UpgradeUI
	queue_free()
