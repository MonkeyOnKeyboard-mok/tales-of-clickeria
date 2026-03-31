extends Resource
class_name Cards

@export var name: String
@export var description: String
@export var icon: Texture2D
@export var rarity: int = 1
@export var effect: String  # or maybe an enum
@export var value: float = 0.0
