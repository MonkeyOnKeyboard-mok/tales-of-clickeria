extends Node2D
class_name Enemy

@export var nombre_enemigo: String = "Monstruo"

# Referencias a Componentes (Composición)
@onready var level_component: LevelComponent = $LevelComponent
@onready var health_bar: HealthBar = $HealthBar # Asumiendo que tu nodo se llama así

# Estado interno (opcional, para lógica de muerte)
var esta_vivo: bool = true

signal enemigo_muerto()

func _ready() -> void:
	# 1. Validar que existan los componentes necesarios
	if not level_component:
		push_error("ERROR: El enemigo '%s' no tiene un LevelComponent hijo." % nombre_enemigo)
		return
	
	if not health_bar:
		push_error("ERROR: El enemigo '%s' no tiene un HealthBar hijo." % nombre_enemigo)
		return

	# 2. Conectar la señal del componente para recibir stats iniciales y actualizaciones
	level_component.stats_calculadas.connect(_aplicar_nuevas_stats)
	
	# 3. Forzar cálculo inicial basado en la etapa global actual
	level_component.recalcular_stats(GestorEtapa.etapa_actual)

# Esta función es llamada automáticamente por LevelComponent cuando hay nuevas stats
func _aplicar_nuevas_stats(nueva_salud_max: float, nuevo_dps: float, nuevas_resistencias: Dictionary) -> void:
	# Actualizamos la barra de vida directamente con el nuevo máximo
	# Tu clase HealthBar ya maneja la animación y el clamp internamente
	health_bar.set_max_health(nueva_salud_max)
	health_bar.set_health(nueva_salud_max)
	
	print("[Enemy] %s actualizado. Nueva Vida Máx: %.1f" % [nombre_enemigo, nueva_salud_max])

# Función principal para recibir daño
func recibir_daño(cantidad: float, tipo_dano: String = "Fisico") -> void:
	if not esta_vivo or not level_component:
		return

	# 1. Calcular resistencia usando el componente
	var daño_real = level_component.aplicar_resistencia(cantidad, tipo_dano)
	
	# 2. Aplicar daño a la HealthBar
	# La HealthBar se encarga de restar, animar y clamping (no bajar de 0)
	health_bar.take_damage(daño_real)
	
	# 3. Verificar muerte consultando a la HealthBar
	if health_bar.health <= 0.0:
		morir()

func morir() -> void:
	if not esta_vivo: return
	esta_vivo = false
	
	print("¡%s ha sido derrotado!") 
	enemigo_muerto.emit()
	
	# Pequeña pausa antes de destruir para ver la barra vacía (opcional)
	await get_tree().create_timer(0.5).timeout
	queue_free()

# Loop de ataque (Daño al jugador)
func _process(delta: float) -> void:
	if esta_vivo and level_component:
		var dps = level_component.dps_calculado
		if dps > 0:
			# Aquí llamarías a la función de daño del jugador
			# GameManager.jugador.recibir_daño(dps * delta)
			pass

func _on_area_2d_input_event(_viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		health_bar.take_damage(50)
