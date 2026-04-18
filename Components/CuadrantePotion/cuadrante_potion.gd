extends Node
## enums
## consts
## exports
## public vars
var counter : int = 0
var types : Array [String]
## private vars
var target : TextureRect = null

## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	types = ["fire", "cold", "light"]

func _process(_delta: float) -> void:
	pass

## public methods

func try_level_up() -> void:
	#print("trying to apply level up")
	if target:
		target.set_color(types.pick_random())
		queue_free()
		#print("Floor set up succsefuly")
	else: 
		self.global_position = Vector2(250,50)
		#print("no target to set up")

## private methods


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().get_parent() == self: return
	if target: 
		#print("Already have a target")
		return
	#print("colliding")
	if area.is_in_group("cuadrante"):
		target = area.get_parent()
		target.glow()
		print(target)

func _on_area_2d_area_exited(area: Area2D) -> void:
# If the area we just left was our current target
	if area.get_parent() == target:
		if target and target.has_method("unglow"):
			target.unglow()
			target = null
			#print("Target freed")
# Now check if we're still overlapping with another area
		var overlaps = $Area2D.get_overlapping_areas()
		for other in overlaps:
			if other.is_in_group("cuadrante"):
				target = other.get_parent()
				if target.has_method("glow"):
					target.glow()
				print("New target:", target)
				break   # stop after first valid overlap
