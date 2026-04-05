extends Node

var multiplicador_base : float = 3.0

# Variables principales
var precios : Dictionary = {
	"pocion_basica": 50.0,
	"mago_fuego" : 10.0,
	"mago_cold" : 10.0,
	"mago_light" : 10.0,
}

# Configuración inicial (puedes cargar esto desde un archivo JSON luego)
func _ready() -> void:
	Event.connect("update_price", actualizar_precios)
	precios  = {
	"pocion_basica": 50.0,
	"mago_fuego" : 10.0,
	"mago_cold" : 10.0,
	"mago_light" : 10.0,
}

# Configurar precios dinámicos (opcional, para subir precios según nivel)
func actualizar_precios(key: String) -> void:
	print("Price to update: ", key)
	precios[key] *= multiplicador_base
	print("New price: ", key)
	
