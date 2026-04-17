extends Node

## Variables principales
var precios : Dictionary = {
	"pocion_basica": 25.0,
	"mago_fuego" : 10.0,
	"mago_cold" : 10.0,
	"mago_light" : 10.0,
	"hourglass" : 1000.0,
	"cuadrante_potion" : 3000.0,
	"mago_healer" : 30000.0
}

var multiplicador : Dictionary = {
	"pocion_basica": 1.0,
	"mago_fuego" : 3.0,
	"mago_cold" : 3.0,
	"mago_light" : 3.0,
	"hourglass" : 5.0,
	"cuadrante_potion" : 2.0,
}

## Configuración inicial (puedes cargar esto desde un archivo JSON luego)
func _ready() -> void:
	Event.connect("update_price", actualizar_precios)
	precios  = {
	"pocion_basica": 25.0,
	"mago_fuego" : 10.0,
	"mago_cold" : 10.0,
	"mago_light" : 10.0,
	"hourglass" : 1000.0,
	"cuadrante_potion" : 3000.0,
	"mago_healer" : 30000.0
}
	multiplicador = {
	"pocion_basica": 1.0,
	"mago_fuego" : 3.0,
	"mago_cold" : 3.0,
	"mago_light" : 3.0,
	"hourglass" : 5.0,
	"cuadrante_potion" : 2.0,
	"mago_healer" : 2.0
}

## Configurar precios dinámicos (opcional, para subir precios según nivel)
func actualizar_precios(key: String) -> void:
	print("Price to update: ", key)
	precios[key] *= multiplicador[key]
	print("New price: ", precios[key])
