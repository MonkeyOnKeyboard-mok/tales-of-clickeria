extends Node
## enums
## consts
## exports
## public vars
## private vars
## onready vars
# "obj_" for node references;
## built-in override methods


func _ready():
	pass

## private methods

func set_texture(texture : Texture2D) -> void:
	print("Texture set")
	self.texture = texture

func _on_area_2d_mouse_entered() -> void:
	print("Mouse entered the area!")

func _on_area_2d_mouse_exited() -> void:
	print("Mouse exited the area!")
