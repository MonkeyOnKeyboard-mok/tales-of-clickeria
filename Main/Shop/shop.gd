extends Node
## enums
## consts
const FIRE = preload("uid://c6758l4ovsyf1")
const LIGHT = preload("uid://bg5nnqgeloj4y")
## exports
## public vars
## private vars
var displayed : bool = false
var offset : Vector2 = Vector2.ZERO
## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

## public methods

## private methods



func _on_texture_button_pressed() -> void:
	print("button pressed")
	get_parent().spawn_minion(FIRE)


func _on_arrow_pressed() -> void:
	if displayed: 
		offset = Vector2(200, 0)
	else: 
		offset = Vector2(-200, 0)
	displayed = !displayed
	var final_pos = self.global_position + offset
	var overshoot = final_pos + Vector2(offset.x * 0.2, 0) # go past target
	var tween = create_tween()
	tween.tween_property(self, "global_position", overshoot, 0.25)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", final_pos, 0.15)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)


 


func _on_minion_luz_pressed() -> void:
	print("button pressed")
	get_parent().spawn_minion(LIGHT)
