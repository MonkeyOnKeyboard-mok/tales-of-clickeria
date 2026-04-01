extends Node
class_name MinionManager
## enums
## consts
## exports
## public vars
## private vars
## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

## public methods
func set_new_target(enemy: Node2D) -> void:   ## El target de los minions se settea cuando spawnea un enemigo
	for child in get_children():
		if child is Node2D:
			child.new_target(enemy)
			print("minion new target set")

## private methods  ## Borrar??
func arrange_children(): ## Esto se asegura de que los minions estén siempre centrados sin importar cuántos haya
	var spacing := 120
	var count := get_child_count() 
	print("count: ",count)
	var total_width = (count - 1) * spacing
	var start_x = -total_width / 2.0
	var i := 0
	for child in get_children():
		if child is Node2D:
			child.position = Vector2(start_x + i * spacing, 0)
			i += 1
