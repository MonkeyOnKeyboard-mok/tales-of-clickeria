extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_tree().paused = false
	Event.pause_game.connect(_toogle_pause)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _toogle_pause() -> void:
	if get_tree().paused:
		visible = false
		get_tree().paused = false
	else:
		visible = true
		get_tree().paused = true
