extends Node2D
class_name Enemy

@export var nombre_enemigo: String = "Monstruo"

# Referencias a Componentes (Composición)
@onready var level_component: LevelComponent = %LvLComponent
@onready var health_bar: HealthBar = %HealthBar # Asumiendo que tu nodo se llama así
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
func _aplicar_nuevas_stats(nueva_salud_max: float, nuevo_dps: float, nuevas_resistencias: Dictionary, exp_granted : float) -> void:
	# Actualizamos la barra de vida directamente con el nuevo máximo
	# Tu clase HealthBar ya maneja la animación y el clamp internamente
	health_bar.set_max_health(nueva_salud_max)
	health_bar.set_health(nueva_salud_max)
	health_bar.value = nueva_salud_max
	
	print("[Enemy] %s actualizado. Nueva Vida Máx: %.1f" % [nombre_enemigo, nueva_salud_max])

# Loop de ataque (Daño al jugador)
func _process(_delta: float) -> void:
	if esta_vivo and level_component:
		var dps = level_component.dps_calculado
		if dps > 0:
			# Aquí llamarías a la función de daño del jugador
			# GameManager.jugador.recibir_daño(dps * delta)
			pass

func _on_area_2d_input_event(_viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		health_bar.take_damage(GlobalStats.playerStats["main_attack"])
		Event.emit_signal("spawn_particle", get_global_mouse_position())
		print("mouse poistion at spawn moment:" ,get_global_mouse_position())
		Event.emit_signal("gain_juice", GlobalStats.playerStats["main_attack_juice"])
