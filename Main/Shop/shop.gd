extends Node
## enums
## consts
## exports
## public vars
## private vars
var displayed : bool = false
var offset : Vector2 = Vector2.ZERO
## onready vars
@onready var label_fire: Label = $GridContainer/MinionFuego/Label
@onready var label_light: Label = $GridContainer/MinionLuz/Label
@onready var label_cold: Label = $GridContainer/MinionCold/Label
@onready var label_basic_potion: Label = $GridContainer/HealthPotion/Label
@onready var label_hourglass: Label = $GridContainer/HourGlass/Label
@onready var label_cuadrante_potion: Label = $GridContainer/CuadrantePotion/Label
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	label_fire.text = "Fire Wizard \n       " + str(int(EconomiaManager.precios["mago_fuego"]))
	label_light.text = "Light Wizard \n       " + str(int(EconomiaManager.precios["mago_light"]))
	label_cold.text = "Cold Wizard \n       " + str(int(EconomiaManager.precios["mago_cold"]))
	label_basic_potion.text = "Basic Potion \n       " + str(int(EconomiaManager.precios["pocion_basica"]))
	label_hourglass.text = "Hourglass \n       " + str(int(EconomiaManager.precios["hourglass"]))
	label_cuadrante_potion.text = "Mystery Mix \n       " + str(int(EconomiaManager.precios["cuadrante_potion"]))

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


## Señales de los botones
func _on_texture_button_pressed() -> void:
	_spawn_bought_item("minion", Event.MINION_TYPES["fire"], EconomiaManager.precios["mago_fuego"], "mago_fuego") 
func _on_minion_luz_pressed() -> void:
	_spawn_bought_item("minion",Event.MINION_TYPES["light"],EconomiaManager.precios["mago_light"], "mago_light") 
func _on_minion_cold_pressed() -> void:
	_spawn_bought_item("minion",Event.MINION_TYPES["cold"], EconomiaManager.precios["mago_cold"], "mago_cold") 
func _on_health_potion_pressed() -> void:
	_spawn_bought_item("potion", 5.0, EconomiaManager.precios["pocion_basica"], "pocion_basica") 
	## Para las pociones, el segundo argumento es la vida que curan
func _on_hourglass_pressed() -> void:
	_spawn_bought_item("artifact", "spawn_hourglass", EconomiaManager.precios["hourglass"], "hourglass") 
	## Para los artefactos, el segundo argumento es una String con el artefacto
func _on_level_up_pressed() -> void:
	_spawn_bought_item("artifact", "spawn_cuadrante_potion", EconomiaManager.precios["cuadrante_potion"], "cuadrante_potion") 
	### Para los artefactos, el segundo argumento es una String con el artefacto

func _spawn_bought_item(itemType: String, data, amount:float, key: String) -> void:
	if GlobalStats.playerStats["juice"] < amount: 
			print("Not enough juice to buy this item")
			return
	else: 
		match itemType:
			"minion":
				if GlobalStats.minion_counter >= 6: return
				Event.emit_signal("spent_juice", amount)
				Event.emit_signal("spawn_minion",data)
				Event.emit_signal("update_price", key)
				print(data.type + " Wizard bought")
			"potion":
				Event.emit_signal("spent_juice", amount)
				Event.emit_signal("player_gained_health", data)
			"artifact":
				Event.emit_signal("spent_juice", amount)
				Event.emit_signal("update_price", key)
				Event.emit_signal(data)
