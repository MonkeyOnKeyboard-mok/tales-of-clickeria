extends Control

@onready var lbl_etapa: Label = $HBoxContainer/TextureRect/LabelEtapa
@onready var btn_siguiente: Button = $HBoxContainer/ButtonSiguienteEtapa


# Necesitas una referencia al enemigo actual en escena
@export var enemigo_actual: Node2D 

var counter : int = 0

func _ready() -> void:
	# Conectar señal del gestor
	counter = 0
	GestorEtapa.etapa_cambiada.connect(_actualizar_ui_etapa)
	btn_siguiente.pressed.connect(_on_btn_siguiente_pressed)
	
	_actualizar_ui_etapa()

func _process(_delta: float) -> void:
	pass

func _actualizar_ui_etapa() -> void:
	print("Nueva etapa XDXD : ", GestorEtapa.etapa_actual)
	lbl_etapa.text = "Etapa %d" % GestorEtapa.etapa_actual
	# Si tenemos un enemigo en escena, lo actualizamos
	if enemigo_actual and enemigo_actual.has_method("actualizar_stats"):
		enemigo_actual.counter += 1
		enemigo_actual.actualizar_stats(GestorEtapa.etapa_actual)

func _on_btn_siguiente_pressed() -> void:
	if GestorEtapa.kill_count != GestorEtapa.threshold_etapas[GestorEtapa.current_etapa[GestorEtapa.counter]]:
		print("You are not ready for the next zone")
		return
	if GestorEtapa.etapa_actual == 8 and GestorEtapa.boss_defeatd == true: 
		print("You already won")
		return
	# Lógica opcional: ¿Puede avanzar solo si mató al anterior?
	# Por ahora, permitimos avanzar libremente para probar
	GestorEtapa.kill_count = 0
	GestorEtapa.counter += 1
	GestorEtapa.siguiente_etapa()
	Event.emit_signal("spawn_enemy")
	print(
		"Print desde el UI Manager: \n",
		"Kill Count:  ", GestorEtapa.kill_count, "\n",
		"Current Etapa:  ", GestorEtapa.current_etapa[GestorEtapa.counter], "\n",
	)
