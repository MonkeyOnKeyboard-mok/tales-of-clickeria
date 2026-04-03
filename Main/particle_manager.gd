extends Node
## enums
## consts
const JUICE_PARTICLE = preload("uid://bhyfuyf85hh86")
## exports
## public vars
## private vars
## onready vars
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	Event.connect("spawn_particle", spawn_particle)

func _process(_delta: float) -> void:
	#if $Path2D.get_child_count() > 0:
		#for child in $Path2D.get_children():
			#if child is PathFollow2D:
				#print("PF pos:", child.global_position)
	pass


## public methods
func spawn_particle(pos: Vector2) -> void:
	print("spawning particle at:" , pos)
	var pf = PathFollow2D.new()
	$Path2D.add_child(pf)
	pf.progress_ratio = 0.0
	pf.rotates = false   # prevents unwanted rotation
	# Instance the particle and add it under this PathFollow
	var juice_particle = JUICE_PARTICLE.instantiate()
	pf.add_child(juice_particle)
	juice_particle.global_position = pos
	# Animate the PathFollow along the curve
	var tween1 = create_tween()
	tween1.tween_property(juice_particle, "position", $Path2D.curve.get_point_position(0), 0.5) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var tween = create_tween()
	tween.tween_property(pf, "progress_ratio", 1.0, 1.0) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func(): pf.queue_free())
