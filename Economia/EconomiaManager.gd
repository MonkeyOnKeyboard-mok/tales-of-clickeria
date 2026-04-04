extends Node

# Señales para avisar a la UI cuando el oro cambia
signal oro_actualizado(cantidad: int)
signal transaccion_exitosa(tipo: String)
signal transaccion_fallida(mensaje: String)

# Variables principales
var oro: int = 0
var precio_pocion: int = 50
var precio_recluta_basica: int = 100

# Configuración inicial (puedes cargar esto desde un archivo JSON luego)
func _ready() -> void:
	# Inicializamos con 0 o un valor de prueba
	oro = 0
	#print("Sistema de Economía iniciado.")

# --- Funciones Públicas (Las que usaremos desde otros scripts) ---

# Añadir oro (ej. al matar un enemigo)
func ganar_oro(cantidad: int) -> void:
	if cantidad > 0:
		oro += cantidad
		oro_actualizado.emit(oro)
		#print("Ganaste %d de oro. Total: %d" % [cantidad, oro])

# Gastar oro (ej. comprar algo)
func gastar_oro(costo: int, concepto: String) -> bool:
	if oro >= costo:
		oro -= costo
		oro_actualizado.emit(oro)
		transaccion_exitosa.emit(concepto)
		#print("Compraste: %s por %d de oro." % [concepto, costo])
		return true
	else:
		transaccion_fallida.emit("No tienes suficiente oro para: " + concepto)
		#print("Fallo: No hay suficiente oro para %s" % concepto)
		return false

# Obtener el oro actual (útil para verificar antes de mostrar botones)
func obtener_oro() -> int:
	return oro

# Configurar precios dinámicos (opcional, para subir precios según nivel)
func actualizar_precios(multiplicador: float) -> void:
	precio_pocion = int(precio_pocion * multiplicador)
	precio_recluta_basica = int(precio_recluta_basica * multiplicador)
