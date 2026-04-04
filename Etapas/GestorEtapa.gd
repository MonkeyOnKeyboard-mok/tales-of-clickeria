extends Node

signal etapa_cambiada(nueva_etapa: int)
signal enemigo_derrotado()

# Configuración actual
var etapa_actual: int = 1

# Constantes de balanceo (Ajustables según necesites)
const SALUD_BASE: float = 100.0
const DPS_BASE: float = 10.0
const MULTIPLICADOR_POR_NIVEL: float = 3.0 # Cada nivel es 50% más fuerte ## Santi: Lo cambié pa probar

# Función para obtener las stats de un enemigo según la etapa
func obtener_stats_enemigo(etapa: int) -> Dictionary:
	var modificador = pow(MULTIPLICADOR_POR_NIVEL, etapa - 1)
	
	# Cálculo de stats
	var salud_max = SALUD_BASE * modificador
	var dps = DPS_BASE * modificador
	
	# Lógica de Resistencias (Preparado para el futuro)
	var resistencias = {}
	if etapa == 1:
		resistencias = {"tipo": "Nula", "valor": 0.0} # Sin resistencia
	elif etapa >= 2:
		# Aquí podrías asignar elementos aleatorios o fijos por etapa
		resistencias = {"tipo": "Basica", "valor": 0.1} # 10% reducción de daño
	
	return {
		"etapa": etapa,
		"salud_max": salud_max,
		"salud_actual": salud_max,
		"dps": dps,
		"resistencias": resistencias
	}

# Función para avanzar de etapa
func siguiente_etapa() -> void:
	etapa_actual += 1
	print("Avanzando a Etapa %d" % etapa_actual)
	etapa_cambiada.emit(etapa_actual)
	# Aquí podrías guardar el progreso si quisieras

# Función para reiniciar (Game Over o Nueva Partida)
func reiniciar_etapas() -> void:
	etapa_actual = 1
	etapa_cambiada.emit(etapa_actual)
