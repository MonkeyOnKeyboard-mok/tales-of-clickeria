extends Node
class_name EnemyAttack

## exports
# Referencia al recurso de stats que ya tenías
@export var stats : EnemyStats 

## signals
signal enemy_attacked(damage: float, type: String)

## onready vars
@onready var timer: Timer = $Timer

# Variables internas para el escalado
var current_damage: float = 0.0
var current_attack_speed: float = 0.0
var etapa_asignada: int = 1

# Constantes de balanceo (Deben coincidir con las de LevelComponent para coherencia)
const BASE_DAMAGE: float = 3.0
const BASE_ATTACK_SPEED: float = 3.0 # Segundos entre ataques
const MULTIPLICADOR_POR_NIVEL: float = 1.5 

func _ready() -> void:
	# 1. Obtener la etapa actual del gestor global
	etapa_asignada = GestorEtapa.etapa_actual
	
	# 2. Calcular stats basados en la etapa
	_calcular_stats_por_etapa(etapa_asignada)
	
	# 3. Configurar el timer inicial
	_configurar_timer()
	
	_buscar_y_conectar_jugador()
	

## private methods

func _buscar_y_conectar_jugador() -> void:
	# Estrategia A: Buscar por Grupo (Muy robusto)
	# Asegúrate de que tu nodo Jugador tenga el grupo "jugador" en el Inspector
	var jugadores = get_tree().get_nodes_in_group("jugador")
	
	if jugadores.size() > 0:
		var objetivo = jugadores[0] # Tomamos el primero
		# Conectamos la señal de ESTE enemigo a la función del jugador
		self.enemy_attacked.connect(objetivo.recibir_ataque_enemigo)
		print("[EnemyAttack] Conectado al jugador: %s" % objetivo.name)
	else:
		push_warning("EnemyAttack no encontró ningún nodo en el grupo 'jugador'")

func _calcular_stats_por_etapa(etapa: int) -> void:
	# Fórmula exponencial igual que en LevelComponent
	var factor_escala = pow(MULTIPLICADOR_POR_NIVEL, etapa - 1)
	# Calculamos Daño y Velocidad
	current_damage = BASE_DAMAGE * factor_escala
	current_attack_speed = BASE_ATTACK_SPEED
	# Nota: Dividimos la velocidad por el factor para que ataquen MÁS RÁPIDO en niveles altos.
	# Si prefieres que solo suba el daño y la velocidad sea fija, usa: current_attack_speed = BASE_ATTACK_SPEED
	
	# Actualizamos el recurso de stats si es necesario para otros scripts
	if stats:
		stats.base_damage = current_damage
		stats.type = "null" # Por defecto, se puede cambiar luego por elemento
		stats.crit_chance = 0.0
		stats.attack_speed = current_attack_speed
		
	#print("[EnemyAttack] Etapa %d | Daño: %.2f | Velocidad Ataque: %.2f seg" % [etapa, current_damage, current_attack_speed])

func _configurar_timer() -> void:
	if timer:
		timer.wait_time = current_attack_speed
		# Reiniciamos el timer para aplicar el nuevo tiempo
		timer.stop()
		timer.start()

# Función pública para actualizar si el enemigo "sube de nivel" en escena (opcional)
func actualizar_por_etapa(nueva_etapa: int) -> void:
	etapa_asignada = nueva_etapa
	_calcular_stats_por_etapa(nueva_etapa)
	_configurar_timer()

func _on_timer_timeout() -> void:
	# Emitimos el daño calculado junto con la señal
	emit_signal("enemy_attacked", current_damage)
