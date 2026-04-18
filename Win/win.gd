extends Node
## enums
## consts
## exports
## public vars
var button_type = null
## private vars
## onready vars
@onready var fade_transition: ColorRect = $ColorRect

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	$ColorRect/AnimationPlayer.play("fade_out")
	##Audio.menu.play()  ##Game Over Audio
	pass

func _process(_delta: float) -> void:
	pass

## public methods

## private methods

func _on_jugar_pressed() -> void:
	Audio.click()
	button_type = "start"
	fade_transition.show()
	$ColorRect/Fade_timer.start()
	$ColorRect/AnimationPlayer.play("fade_in")

func _on_salir_pressed() -> void:
	Audio.click()
	button_type = "salir"
	fade_transition.show()
	$ColorRect/Fade_timer.start()
	$ColorRect/AnimationPlayer.play("fade_in")

func _on_fade_timer_timeout() -> void:
	match button_type:
		"start": 
			get_tree().change_scene_to_file("res://Main/main.tscn")
		"salir":
			get_tree().change_scene_to_file("res://Menu/menu.tscn")
