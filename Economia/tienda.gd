extends Control

# Referencias a los nodos de la interfaz
@onready var lbl_oro: Label = $VBoxContainer/LabelGold
@onready var btn_pocion: Button = $VBoxContainer/BuyPotion
@onready var btn_mago: Button = $VBoxContainer/BuyWizard
@onready var lbl_mensaje: Label = $VBoxContainer/LabelError
@onready var btn_money: Button = $VBoxContainer/GetMoney

func _ready() -> void:
	# Conectamos las señales del gestor de economía
	EconomiaManager.oro_actualizado.connect(_actualizar_ui_oro)
	EconomiaManager.transaccion_exitosa.connect(_mostrar_exito)
	EconomiaManager.transaccion_fallida.connect(_mostrar_error)
	
	# Conectamos los botones a sus funciones
	btn_pocion.pressed.connect(_comprar_pocion)
	btn_mago.pressed.connect(_reclutar_mago)
	btn_money.pressed.connect(_get_money)
	
	# Actualizamos la UI al iniciar
	_actualizar_ui_oro(EconomiaManager.obtener_oro())

# --- Funciones de Interfaz ---

func _actualizar_ui_oro(nuevo_oro: int) -> void:
	lbl_oro.text = "Oro Disponible: %d" % nuevo_oro
	
	# Desactivar botones si no alcanza el oro (mejora de UX)
	btn_pocion.disabled = nuevo_oro < EconomiaManager.precio_pocion
	btn_mago.disabled = nuevo_oro < EconomiaManager.precio_recluta_basica

func _mostrar_exito(concepto: String) -> void:
	lbl_mensaje.text = "¡Compra exitosa: %s!" % concepto
	lbl_mensaje.add_theme_color_override("font_color", Color.GREEN)
	_limpiar_mensaje()

func _mostrar_error(mensaje: String) -> void:
	lbl_mensaje.text = mensaje
	lbl_mensaje.add_theme_color_override("font_color", Color.RED)
	_limpiar_mensaje()

func _limpiar_mensaje() -> void:
	# Espera 2 segundos y borra el mensaje
	await get_tree().create_timer(2.0).timeout
	lbl_mensaje.text = ""

# --- Lógica de Compra ---

func _comprar_pocion() -> void:
	var costo = EconomiaManager.precio_pocion
	if EconomiaManager.gastar_oro(costo, "Poción de Vida"):
		pass
		# AQUÍ IRÍA LA LÓGICA REAL DE DAR LA POCIÓN AL JUGADOR
		#print("Lógica: Se agregó 1 poción al inventario.")
		# Ejemplo: Inventorio.agregar_item("pocion")

func _reclutar_mago() -> void:
	var costo = EconomiaManager.precio_recluta_basica
	if EconomiaManager.gastar_oro(costo, "Mago Básico"):
		# AQUÍ IRÍA LA LÓGICA PARA INSTANCIAR UN MAGO EN EL COMBATE
		#print("Lógica: Se preparó un nuevo mago para el altar.")
		Event.emit_signal("spawn_minion", Event.MINION_TYPES.values().pick_random())
		# Ejemplo: GameManager.reclutar_mago_tipo("basico")

func _get_money() -> void:
	#EconomiaManager.ganar_oro(50)
	Event.emit_signal("gain_juice",50.0)
