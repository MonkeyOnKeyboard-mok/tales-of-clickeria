extends Node2D # O el tipo de nodo que uses para tu enemigo

@export var nombre_enemigo: String = "Monstruo Básico"

# Variables de estado
var salud_actual: float = 0.0
var salud_maxima: float = 0.0
var dps_enemigo: float = 0.0
var resistencias: Dictionary = {}

# Señales
signal muerte()
signal salud_cambiada(porcentaje: float)

# Referencias a nodos visuales (Opcional, para barras de vida)
@onready var barra_vida: ProgressBar = $ProgressBar # Asume que tienes una barra hija

func _ready() -> void:
	# Inicializar con valores por defecto si no se cargan
	actualizar_stats(1)

# Función llamada por el GestorEtapa para configurar al enemigo
func actualizar_stats(etapa: int) -> void:
	var datos = GestorEtapa.obtener_stats_enemigo(etapa)
	
	salud_maxima = datos["salud_max"]
	salud_actual = salud_maxima
	dps_enemigo = datos["dps"]
	resistencias = datos["resistencias"]
	
	# Actualizar UI visual
	if barra_vida:
		barra_vida.max_value = salud_maxima
		barra_vida.value = salud_actual
	
	print("Enemigo Etapa %d listo. Salud: %.2f, DPS: %.2f" % [etapa, salud_maxima, dps_enemigo])

# Función para recibir daño
func recibir_daño(cantidad: float, tipo_daño: String = "Fisico") -> float:
	# 1. Calcular resistencia (Lógica futura preparada)
	var factor_resistencia = 1.0
	if resistencias.has("valor"):
		# Si hay resistencia, reducimos el daño
		# Ejemplo simple: si resistencia es 0.1, recibes 90% del daño
		factor_resistencia = 1.0 - resistencias["valor"]
		
		# AQUÍ IRÍA LA LÓGICA DE ELEMENTOS DEL GDD (Fuego vs Hielo, etc.)
		# if tipo_daño == "Fuego" and resistencias["tipo"] == "Agua":
		#     factor_resistencia = 0.5 # Doble daño
	
	var daño_final = cantidad * factor_resistencia
	
	# 2. Aplicar daño
	salud_actual -= daño_final
	salud_actual = max(0, salud_actual) # No bajar de 0
	
	# 3. Actualizar UI
	if barra_vida:
		barra_vida.value = salud_actual
	
	salud_cambiada.emit(salud_actual / salud_maxima)
	
	# 4. Verificar muerte
	if salud_actual <= 0:
		morir()
	
	return daño_final

func morir() -> void:
	print("Enemigo de Etapa %d derrotado!" % GestorEtapa.etapa_actual)
	muerte.emit()
	# Aquí podrías poner animación de muerte antes de queue_free()
	queue_free()

# Loop de ataque del enemigo (Daño al jugador)
func _process(delta: float) -> void:
	if salud_actual > 0 and dps_enemigo > 0:
		# Infligir DPS al jugador (necesitas referencia al jugador)
		# Jugador.recibir_daño(dps_enemigo * delta)
		pass 
