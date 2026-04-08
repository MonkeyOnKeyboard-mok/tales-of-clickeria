extends Node
## enums
## consts
## exports
## public vars
var counter : int = 0
## private vars
var target : Node2D = null

## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

## public methods

func try_level_up() -> void:
	print("trying to apply level up")
	if target:
		target.level_up()
		queue_free()
		print("levelled up succsefuly")
	else: 
		self.global_position = Vector2(25,360)
		print("no target to level up")

## private methods


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().get_parent() == self: return
	if target: 
		print("Already have a target")
		return
	print("colliding")
	if area.get_parent().get_parent().is_in_group("minion"):
		target = area.get_parent().get_parent() 
		target.glow()
		print(target)

#func _on_area_2d_area_exited(area: Area2D) -> void:
	#if area.get_parent().get_parent() == target: 
		#if area.get_parent().get_parent().has_method("unglow"):
			#area.get_parent().get_parent().unglow()
			#target = null
			#print("Target freed")
			
func _on_area_2d_area_exited(area: Area2D) -> void:
# If the area we just left was our current target
	if area.get_parent().get_parent() == target:
		if target and target.has_method("unglow"):
			target.unglow()
			target = null
			print("Target freed")
# Now check if we're still overlapping with another area
		var overlaps = $Area2D.get_overlapping_areas()
		for other in overlaps:
			var candidate = other.get_parent().get_parent()
			if candidate.is_in_group("minion"):
				target = candidate
				if target.has_method("glow"):
					target.glow()
				print("New target:", target)
				break   # stop after first valid overlap
