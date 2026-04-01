extends Control

@export var upgrade_pool: Array[Cards]  # Drag your Upgrade .tres files here in the Inspector
const CARD = preload("uid://bgrkg8wdxx0ln")
@onready var container = $HBoxContainer   # Where the 3 upgrades will be displayed
@onready var main = get_tree().get_root().get_node("Main") # adjust path

func _ready():
	var _err = main.connect("enemy_just_died", Callable(self, "show_upgrades"))
	hide() 
	
func show_upgrades(count: int = 3):
	for child in container.get_children():
		child.queue_free()
	var upgrades = get_random_upgrades(count)
	for card in upgrades:
		var choice = CARD.instantiate()
		container.add_child(choice)
		choice.set_card(card)
		print(choice.global_position)
	show()
	
func get_random_upgrades(count: int = 3) -> Array[Cards]:
	var shuffled = upgrade_pool.duplicate()
	shuffled.shuffle()
	return shuffled.slice(0, count)

#func emit_signal_to_global(type: String) -> void:
	#print("señal para el global")
