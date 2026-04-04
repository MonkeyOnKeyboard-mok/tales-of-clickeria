extends Control

@onready var lbl_etapa: Label = $HBoxContainer/LabelEtapa
@onready var btn_siguiente: Button = $HBoxContainer/ButtonSiguienteEtapa
@onready var timer: Timer = $Timer
@onready var timerLabel: Label = $Timer/Label

var timerBaseTime : float = 30.0

# Necesitas una referencia al enemigo actual en escena
@export var enemigo_actual: Node2D 

func _ready() -> void:
	timer.start(timerBaseTime)
	# Conectar señal del gestor
	GestorEtapa.etapa_cambiada.connect(_actualizar_ui_etapa)
	btn_siguiente.pressed.connect(_on_btn_siguiente_pressed)
	
	_actualizar_ui_etapa(GestorEtapa.etapa_actual)

func _process(_delta: float) -> void:
	timerLabel.text = str(round(timer.time_left))

func _actualizar_ui_etapa(nueva_etapa: int) -> void:
	lbl_etapa.text = "Etapa %d" % nueva_etapa
	
	# Si tenemos un enemigo en escena, lo actualizamos
	if enemigo_actual and enemigo_actual.has_method("actualizar_stats"):
		enemigo_actual.actualizar_stats(nueva_etapa)

func _on_btn_siguiente_pressed() -> void:
	# Lógica opcional: ¿Puede avanzar solo si mató al anterior?
	# Por ahora, permitimos avanzar libremente para probar
	GestorEtapa.siguiente_etapa()
	
	# NOTA: En un juego real, aquí probablemente generarías un NUEVO enemigo
	# en lugar de actualizar el mismo, para reiniciar su posición/animaciones.
	_generar_nuevo_enemigo()

func _generar_nuevo_enemigo() -> void:
	# Ejemplo simple: Si el enemigo murió, creamos uno nuevo
	# Si el enemigo está vivo, quizás no deberíamos permitir cambiar de etapa
	# o reemplazamos al actual.
	
	if enemigo_actual:
		enemigo_actual.queue_free()
	
	# Instanciar nuevo enemigo (Asumiendo que tienes una escena prefebricada)
	# var nuevo_enemigo = preload("res://Escenas/Enemigo.tscn").instantiate()
	# add_child(nuevo_enemigo)
	# enemigo_actual = nuevo_enemigo
	# enemigo_actual.actualizar_stats(GestorEtapa.etapa_actual)
	
	print("Nuevo enemigo generado para Etapa %d" % GestorEtapa.etapa_actual)

func _on_timer_timeout() -> void:
	_on_btn_siguiente_pressed()
	timerBaseTime += 30.0
	timer.start(timerBaseTime)
