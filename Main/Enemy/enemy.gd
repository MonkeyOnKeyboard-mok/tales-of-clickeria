extends Node2D
class_name Enemy

@export var nombre_enemigo: String = "Monstruo"

# Referencias a Componentes (Composición)
@onready var level_component: LevelComponent = %LvLComponent
@onready var health_bar: HealthBar = %HealthBar # Asumiendo que tu nodo se llama así
@onready var sprite: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var projectile_attack: Node2D = $ProjectileAttack

var dying := false

# Estado interno (opcional, para lógica de muerte)
var esta_vivo: bool = true

func _ready() -> void:
	projectile_attack.start_attack_timer()
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
func _aplicar_nuevas_stats(nueva_salud_max: float, _nuevo_dps: float, _nuevas_resistencias: Dictionary) -> void:
	# Actualizamos la barra de vida directamente con el nuevo máximo
	# Tu clase HealthBar ya maneja la animación y el clamp internamente
	if GestorEtapa.etapa_actual == 8:
		health_bar.set_max_health(nueva_salud_max * 100)
		health_bar.set_health(nueva_salud_max * 100)
		health_bar.value = nueva_salud_max * 100
	else:
		health_bar.set_max_health(nueva_salud_max)
		health_bar.set_health(nueva_salud_max)
		health_bar.value = nueva_salud_max
	## Add more projectiles
	match GestorEtapa.etapa_actual:
			3:
				GestorEtapa.projectiles_amount = 3
			5:
				GestorEtapa.projectiles_amount = 4
			6:
				GestorEtapa.projectiles_amount = 5
			7: 
				GestorEtapa.projectiles_amount = 6
			8: 
				GestorEtapa.projectiles_amount = 7

# Loop de ataque (Daño al jugador)
func _process(_delta: float) -> void:
	if esta_vivo and level_component:
		var dps = level_component.dps_calculado
		if dps > 0:
			# Aquí llamarías a la función de daño del jugador
			# GameManager.jugador.recibir_daño(dps * delta)
			pass

func _death_animation() -> void:
	area_2d.queue_free()
# Step 1: jump up and to the right
	var tween = create_tween()
	tween.tween_property(sprite, "position", sprite.position + Vector2(30, -50), 0.3) \
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# Rotate 90° while in the air
	tween.parallel().tween_property(sprite, "rotation_degrees", sprite.rotation_degrees + 90, 0.3) \
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# Step 2: fall back down (bounce #1)
	tween.tween_property(sprite, "position", sprite.position + Vector2(30, 0), 0.2) \
	.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	# Step 3: small bounce up
	tween.tween_property(sprite, "position", sprite.position + Vector2(30, -20), 0.15) \
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# Step 4: settle down (bounce #2)
	tween.tween_property(sprite, "position", sprite.position + Vector2(30, 0), 0.15) \
	.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	# Step 5: rotate 90 degrees
	tween.tween_property(sprite, "rotation_degrees", sprite.rotation_degrees + 90, 0.5) \
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# Step 6: fade out
	tween.tween_property(sprite, "modulate:a", 0.0, 0.5) \
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# Step 7: clean up
	GestorEtapa.kill_count += 1
	Event.emit_signal("enemy_died")
	#print("SE EMITIO SEÑAL MUERTE DEL MONO")
	tween.finished.connect(func(): queue_free())

func _on_area_2d_input_event(_viewport, event: InputEvent, _shape_idx: int) -> void:
	if dying: return
	if event is InputEventMouseButton and event.pressed:
		health_bar.take_damage(GlobalStats.playerStats["main_attack"])
		Event.emit_signal("spawn_particle", get_global_mouse_position())
		Event.emit_signal("gain_juice", GlobalStats.playerStats["main_attack_juice"])
