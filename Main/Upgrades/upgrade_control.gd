extends Control

@export var common_pool: Array[Cards]
@export var rare_pool: Array[Cards]
@export var epic_pool: Array[Cards]
@export var legendary_pool: Array[Cards] # Drag your Upgrade .tres files here in the Inspector
const CARD = preload("uid://bgrkg8wdxx0ln")
@onready var container = $HBoxContainer   # Where the 3 upgrades will be displayed
@onready var main = get_tree().get_root().get_node("Main") # adjust path

func _ready() -> void: 
	Event.player_leveled_up.connect(show_upgrades)
	hide() 

func show_upgrades(count: int = 3):
	for child in container.get_children():
		child.queue_free()
	var selected_upgrades : Array = []
	while selected_upgrades.size() < count:
		var candidate = _get_random_upgrades()
		if not selected_upgrades.has(candidate):
			selected_upgrades.append(candidate)
	for card in selected_upgrades:
		var choice = CARD.instantiate()
		container.add_child(choice)
		choice.set_card(card)
	show()
	
func _get_random_upgrades() -> Cards:
	var pool = _get_rarity()
	var shuffled = pool.duplicate()
	shuffled.shuffle()
	return shuffled[0]

func _get_rarity() -> Array[Cards]: 
	var rarity = randf() * 100
	print("rarity rolled :", rarity)
	if rarity < 50:
		return common_pool
	elif rarity > 50 and rarity < 75: 
		return rare_pool
	elif rarity > 75 and rarity < 90: 
		return epic_pool
	elif rarity > 90 and rarity < 100: 
		return legendary_pool	
	return common_pool
