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
	print("Minions: ", minions)


	
## public methods
func attack() -> void:
	var color_tween = create_tween()
	color_tween.tween_property(text_poly, "modulate", Color(1.532, 0.021, 0.0, 1.0), 0.3)
	_check_overlap()
	color_tween.tween_property(text_poly, "modulate", color_cone, 1.0)
	print("listorti")
	
func set_size() -> void:
	print("Setting size")
	for i in range(text_poly.polygon.size()):
		if text_poly.polygon[i] == text_poly.polygon[0]: 
			pass
		elif text_poly.polygon[i] == text_poly.polygon[1]:
			text_poly.polygon[1] += Vector2(500,0)
			coll_poly.polygon[1] += Vector2(500,0)
			print(text_poly.polygon[i])
		elif text_poly.polygon[i] == text_poly.polygon[2]:
				text_poly.polygon[2] -= Vector2(500,0)
				coll_poly.polygon[2] -= Vector2(500,0)
				print(text_poly.polygon[i])

## private methods
func _check_overlap() -> void:
	var collisions = area_2d.get_overlapping_areas()
	print("Colisiones encontradas: ", collisions)
	if collisions.size() < 1: return
	for i in collisions:
		print("analizando colisiones stun")
		if i.is_in_group("minion"):
			print("Minion encontrado")



func _on_area_2d_area_entered(area: Area2D) -> void:
		if area.is_in_group("minion"):
			print("Minion encontrado")
			minions.append(area.get_parent())

## Arreglar estar poronga

func _on_area_2d_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
