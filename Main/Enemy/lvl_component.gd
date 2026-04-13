extends Node
class_name LevelComponent

# Señales para avisar al enemigo cuando las stats cambian
signal stats_calculadas(salud_max: float, dps: float, resistencias: Dictionary, experience_garantizada : float)

# Configuración de Balanceo (Ajustables desde el Inspector de Godot)
@export_group("Balanceo Base")
@export var salud_base: float = 50.0
@export var dps_base: float = 2.0
@export var exp_granted: float 
@export var multiplicador_crecimiento: float = 5.0 # 50% más fuerte por nivel

# Estado actual del componente
var nivel_actual: int = 1
var salud_maxima_calculada: float = 0.0
var dps_calculado: float = 0.0
var resistencias_actuales: Dictionary = {}
var exp_granted_per_level : Array = []

func _ready() -> void:
	exp_granted_per_level = [10,14,22,41,54,71,72,100]
	# Al iniciar, calculamos las stats según la etapa global actual
	recalcular_stats(GestorEtapa.etapa_actual)

# Función principal: Recibe la etapa global y calcula todo
func recalcular_stats(etapa_global: int) -> void:
	nivel_actual = etapa_global
	
	# Fórmula exponencial: Base * (Multiplicador ^ (Nivel - 1))
	var factor_escala = pow(multiplicador_crecimiento, nivel_actual - 1)
	
	salud_maxima_calculada = salud_base * factor_escala
	dps_calculado = dps_base * factor_escala
	exp_granted = exp_granted_per_level[GestorEtapa.counter]
	# Lógica de Resistencias (Basado en tu GDD)
	#resistencias_actuales = _calcular_resistencias(nivel_actual)
	# Emitimos las nuevas stats para que el Enemy las use
	stats_calculadas.emit(salud_maxima_calculada, dps_calculado, resistencias_actuales)
	#print("[LevelComponent] Etapa %d -> Salud: %.1f, DPS: %.1f" % [nivel_actual, salud_maxima_calculada, dps_calculado])
