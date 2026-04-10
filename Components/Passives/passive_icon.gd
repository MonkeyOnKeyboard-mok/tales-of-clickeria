extends Node
## enums
## consts
## exports
## public vars
## private vars
## onready vars
@onready var panel : Panel = $Panel
@onready var label : RichTextLabel = $Panel/RichTextLabel
@onready var area_2d: Area2D = $Area2D

# "obj_" for node references;
## built-in override methods


func _ready()-> void:
	panel.hide()

func update_values() -> void:
	print("Updating passive's tooltip values")

## private methods

func set_texture(texture : Texture2D) -> void:
	print("Texture set")
	self.texture = texture
	
func set_text(effect: String, type: String) -> void:
	match effect:
		"flat_damage":
			label.text = "Your " + type + " units deal " + str(int(GlobalStats.minionStats[effect][type])) + " more base damage"
		"increased_damage":
			label.text = "Your " + type + " units deal " + str(int((GlobalStats.minionStats[effect][type] - 1.0) * 100.0)) + "% increased damage"
		"harvest":
			label.text = "Your units generate " + str(int((GlobalStats.minionStats[effect][type] - 1.0) * 100.0)) + "% increased juice"
	print("Text set")

func _on_area_2d_mouse_entered() -> void:
	panel.show()
	print("Mouse entered the area!")

func _on_area_2d_mouse_exited() -> void:
	panel.hide()
	print("Mouse exited the area!")
