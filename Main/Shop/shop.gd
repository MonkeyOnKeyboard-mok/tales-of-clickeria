extends Node
## enums
## consts
## exports
## public vars
## private vars
var displayed : bool = false
var offset : Vector2 = Vector2.ZERO
## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

## public methods

## private methods

func _on_arrow_pressed() -> void:
	if displayed: 
		offset = Vector2(200, 0)
	else: 
		offset = Vector2(-200, 0)
	displayed = !displayed
	var final_pos = self.global_position + offset
	var overshoot = final_pos + Vector2(offset.x * 0.2, 0) # go past target
	var tween = create_tween()
	tween.tween_property(self, "global_position", overshoot, 0.25)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", final_pos, 0.15)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

func _on_texture_button_pressed() -> void:
	_spawn_bought_item("minion",Event.MINION_TYPES["fire"], 5.0)

func _on_minion_luz_pressed() -> void:
	_spawn_bought_item("minion",Event.MINION_TYPES["light"], 5.0)

func _on_minion_cold_pressed() -> void:
	_spawn_bought_item("minion",Event.MINION_TYPES["cold"], 5.0)

func _on_health_potion_pressed() -> void:
	_spawn_bought_item("potion", 5.0, 50.0)

func _spawn_bought_item(itemType: String, data, amount:float) -> void:
	if GlobalStats.playerStats["juice"] <= amount: 
			print("Not enough juice to buy this item")
			return
	else: 
		match itemType:
			"minion":
				Event.emit_signal("spent_juice", amount)
				Event.emit_signal("spawn_minion",data)
				print(data.type + " Wizard bought")
			"potion":
				Event.emit_signal("spent_juice", amount)
				Event.emit_signal("player_gained_health", data)
				
	
