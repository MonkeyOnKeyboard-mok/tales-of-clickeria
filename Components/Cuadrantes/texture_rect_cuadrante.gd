extends Node
## enums
## consts
## exports
## public vars
var colors : Dictionary = {}
var target : Node2D = null
var on : bool = false
## private vars
## onready vars
@onready var highlight: TextureRect = $Highlight
@onready var floors: ColorRect = $Floor

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	colors = {
		"fire" : Color(0.659, 0.0, 0.0, 0.784),
		"cold" : Color(0.106, 0.345, 1.0, 0.784),
		"light" : Color(0.616, 0.521, 0.0, 0.784),
	}

func _process(_delta: float) -> void:
	pass

## public methods

func set_color(type : String)  -> void:
	floors.color = colors[type]
	on = true

func glow() -> void:
	highlight.visible = true
	
func unglow() -> void:
	highlight.visible = false

## private methods

func _on_area_2d_area_entered(area: Area2D) -> void:
	if !area.get_parent().get_parent().is_in_group("minion"): 
		return
	if !on: 
		print("Area is off")
		return
	if target or area.get_parent().get_parent().buffed == true: 
		print("Already have target")
		return
	print("Target set")
	target = area.get_parent().get_parent()
	target.buff()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().get_parent() == target:
		print("Target erased")
		target.unbuff()
		target = null
