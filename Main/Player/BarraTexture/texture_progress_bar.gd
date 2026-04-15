extends TextureProgressBar

func _ready():
	value = max_value  

func _input(event):
	if event.is_action_pressed("ui_accept"): 
		value -= 20
		print(value)
		value = clamp(value, min_value, max_value)
	if value >= 92:
		$Mask/Bar_top.visible = false
	else:
		$Mask/Bar_top.visible = true
	# actualizar la posición del sprite
	var ratio = (value - min_value) / (max_value - min_value)
	var y_pos = (1.0 - ratio) * size.y

	var texture = $Mask/Bar_top.sprite_frames.get_frame_texture($Mask/Bar_top.animation, $Mask/Bar_top.frame)
	var sprite_height = texture.get_height()

	y_pos = clamp(y_pos, 0, size.y - sprite_height)

	# 🔥 compensar el offset del Mask
	$Mask/Bar_top.position.y = y_pos - $Mask.position.y
