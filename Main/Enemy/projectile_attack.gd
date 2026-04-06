extends Node
## enums
## consts
const PROJECTILE = preload("uid://bcpb5orwfprdb")
## exports
## public vars
## private vars
## onready vars
@onready var path_1: Path2D = $Path1
@onready var path_2: Path2D = $Path2
@onready var path_3: Path2D = $Path3
@onready var path_4: Path2D = $Path4
@onready var path_5: Path2D = $Path5
@onready var path_6: Path2D = $Path6
@onready var path_7: Path2D = $Path7
@onready var attack_timer: Timer = $Timer
var paths : Array = []
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	paths = [path_1, path_2, path_3 , path_4, path_5 ,path_6 ,path_7]

func _process(_delta: float) -> void:
	pass

## public methods

func start_attack_timer()-> void:
	attack_timer.start(2.0) ## Cambiar por variable de attack speed 

## private methods
func _launch_projectile(path : Path2D) -> void:
	print("El enemigo lanzó un proyectil")
	var projectile = PROJECTILE.instantiate()
	var pf = PathFollow2D.new()
	path.add_child(pf)
	pf.progress_ratio = 0.0
	pf.rotates = false   # prevents unwanted rotation
	#get_parent().sprite.play("attack")
	#await get_parent().sprite.animation_finished
	pf.add_child(projectile)
	projectile.add_to_group("enemy_projectile")
	projectile.anim.play("enemy_generic")
	var tween = create_tween()
	tween.tween_property(pf, "progress_ratio", 1.0, 3.0) \
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func(): pf.queue_free())

func _on_timer_timeout() -> void:
	if get_parent().dying == true: return
	var shuffled_paths = paths.duplicate()
	shuffled_paths.shuffle()
	for i in range(get_parent().projectiles_amount):
		_launch_projectile(shuffled_paths[i])
	attack_timer.start(2.0)
