extends Node
class_name LevelComponent

# Señales para avisar al enemigo cuando las stats cambian
signal stats_calculadas(salud_max: float, dps: float, resistencias: Dictionary, experience_garantizada : float)

# Configuración de Balanceo (Ajustables desde el Inspector de Godot)
@export_group("Balanceo Base")
@export var salud_base: float = 30.0
@export var dps_base: float = 1.0
@export var exp_granted: float = 5.0
@export var multiplicador_crecimiento: float = 1.5 # 50% más fuerte por nivel

# Estado actual del componente
var nivel_actual: int = 1
var salud_maxima_calculada: float = 0.0
var dps_calculado: float = 0.0
var resistencias_actuales: Dictionary = {}

func _ready() -> void:
	# Al iniciar, calculamos las stats según la etapa global actual
	recalcular_stats(GestorEtapa.etapa_actual)

# Función principal: Recibe la etapa global y calcula todo
func recalcular_stats(etapa_global: int) -> void:
	nivel_actual = etapa_global
	
	# Fórmula exponencial: Base * (Multiplicador ^ (Nivel - 1))
	var factor_escala = pow(multiplicador_crecimiento, nivel_actual - 1)
	
	salud_maxima_calculada = salud_base * factor_escala
	dps_calculado = dps_base * factor_escala
	exp_granted = exp_granted * factor_escala
	
	# Lógica de Resistencias (Basado en tu GDD)
	resistencias_actuales = _calcular_resistencias(nivel_actual)
	
	# Emitimos las nuevas stats para que el Enemy las use
	stats_calculadas.emit(salud_maxima_calculada, dps_calculado, resistencias_actuales, exp_granted)
	
	print("[LevelComponent] Etapa %d -> Salud: %.1f, DPS: %.1f" % [nivel_actual, salud_maxima_calculada, dps_calculado])

# Lógica específica de resistencias según el GDD
func _calcular_resistencias(nivel: int) -> Dictionary:
	if nivel == 1:
		return {"tipo": "Nula", "valor": 0.0} # Sin resistencia
	elif nivel >= 2:
		# Aquí podrías añadir lógica aleatoria o por tipo de enemigo
		return {"tipo": "Básica", "valor": 0.1} # 10% reducción
	else:
		return {"tipo": "Nula", "valor": 0.0}

# Función auxiliar para obtener el daño reducido por resistencia
func aplicar_resistencia(dano_entrada: float, tipo_dano: String) -> float:
	var reduccion = resistencias_actuales.get("valor", 0.0)
	
	# FUTURO: Aquí iría la lógica elemental del GDD (Fuego vs Hielo, etc.)
	# if tipo_dano == "Fuego" and resistencias_actuales["tipo"] == "Agua":
	#     reduccion += 0.2 # Extra resistencia
	
	return dano_entrada * (1.0 - reduccion)
