extends Node
## enums
## consts
## exports
## public vars
var colors : Dictionary = {}
var target : Node2D = null
var on : bool = false
var buff_color : Color = Color(0.0, 0.0, 0.0, 0.0)
var buff_value : float = 0.0
## private vars
## onready vars
@onready var highlight: TextureRect = $Highlight
@onready var floors: ColorRect = $Floor
@onready var area_2d: Area2D = $Area2D

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	colors = {
		"fire" : [Color(0.659, 0.0, 0.0, 0.784), Color(1.0, 0.0, 0.0, 1.0), 10.0],
		"cold" : [Color(0.106, 0.345, 1.0, 0.784),  Color(0.276, 0.476, 1.0, 1.0), 10.0],
		"light" : [Color(0.616, 0.521, 0.0, 0.784), Color(1.0, 1.0, 0.0, 1.0), 10.0],
	}



func _process(_delta: float) -> void:
	pass

## public methods

func set_color(type : String)  -> void:
	floors.color = colors[type][0]
	buff_color = colors[type][1]
	buff_value = colors[type][2]
	on = true
	_check_overlaps()

func glow() -> void:
	highlight.visible = true
	
func unglow() -> void:
	highlight.visible = false

func check_if_owned() -> bool:
	if target:
		return true
	else:
		return false

## private methods
func _check_overlaps() -> void:
	print("checking")
	print(area_2d.get_overlapping_areas())
	for body in area_2d.get_overlapping_areas():
		if body.is_in_group("minion"):
			body.get_parent().buff(self)
			print("applying buff to overlapping body")
			target = body.get_parent()
			target.buff_owner = self
			break
		else: print("No body found")
