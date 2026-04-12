extends Node
## enums
## consts
## exports
## public vars
var color_cone : Color = Color(0.871, 0.149, 0.122, 0.31)
## private vars
var minions : Array = []
## onready vars
@onready var text_poly: Polygon2D = $Area2D/CollisionPolygon2D/Polygon2D
@onready var area_2d: Area2D = $Area2D
@onready var coll_poly: CollisionPolygon2D = $Area2D/CollisionPolygon2D

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	set_size()

func _process(_delta: float) -> void:
	pass

## public methods
func attack() -> void:
	var color_tween = create_tween()
	color_tween.tween_property(text_poly, "modulate", Color(1.532, 0.021, 0.0, 1.0), 0.3)
	color_tween.tween_property(text_poly, "modulate", color_cone, 1.0)
	print("listorti")
	for i in minions:
		i.stunned()
	await get_tree().create_timer(1.0).timeout
	queue_free()
	
func set_size() -> void:
	print("Setting size")
	for i in range(text_poly.polygon.size()):
		if text_poly.polygon[i] == text_poly.polygon[0]: 
			pass
		elif text_poly.polygon[i] == text_poly.polygon[1]:
			text_poly.polygon[1] += GestorEtapa.size_increase_cone
			coll_poly.polygon[1] += GestorEtapa.size_increase_cone
			print(text_poly.polygon[i])
		elif text_poly.polygon[i] == text_poly.polygon[2]:
				text_poly.polygon[2] -= GestorEtapa.size_increase_cone
				coll_poly.polygon[2] -= GestorEtapa.size_increase_cone
				print(text_poly.polygon[i])

## private methods

func _on_area_2d_area_entered(area: Area2D) -> void:
		if area.is_in_group("minion"):
			print("Minion encontrado")
			minions.append(area.get_parent())
			print("Minions: ", minions)

func _on_area_2d_area_exited(area: Area2D) -> void:
		if area.is_in_group("minion"):
			print("Minion borrado")
			minions.erase(area.get_parent())
			print("Minions: ", minions)
