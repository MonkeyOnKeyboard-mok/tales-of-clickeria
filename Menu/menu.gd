extends Node
## enums
## consts
## exports
## public vars
var button_type = null
## private vars
## onready vars
@onready var fade_transition: ColorRect = $fade_transition
@onready var creditos_png: TextureRect = $creditosPNG

# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	creditos_png.hide()
	Audio.menu.play()
	$fade_transition/AnimationPlayer.play("fade_out")

func _process(_delta: float) -> void:
	pass

## public methods

## private methods

func _on_jugar_pressed() -> void:
	Audio.click()
	button_type = "start"
	fade_transition.show()
	Audio.menu_out()
	$fade_transition/Fade_timer.start()
	$fade_transition/AnimationPlayer.play("fade_in")

func _on_salir_pressed() -> void:
	Audio.click()
	get_tree().quit()

func _on_creditos_pressed() -> void:
	Audio.click()
	button_type = "credits"
	creditos()


func _on_fade_timer_timeout() -> void:
	match button_type:
		"start": 
			get_tree().change_scene_to_file("res://Main/main.tscn")

func creditos() -> void:
	creditos_png.show()

func _on_salir_creditos_pressed() -> void:
	creditos_png.hide()
