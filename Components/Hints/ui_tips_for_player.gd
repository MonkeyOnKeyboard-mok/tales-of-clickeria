extends Node
## enums
## consts
## exports
## public vars
var play_next_zone_sounds : bool = false
## private vars
## onready vars
@onready var arrow: TextureRect = $FlechitaLevelUp
@onready var next_zone: Label = $"Avanzaralasiguienteetapa"
@onready var waves: Label = $Waves
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if GlobalStats.playerStats["can_level_up"] == true:
		arrow.visible = true
	else:
		arrow.visible = false
	if GestorEtapa.threshold_etapas[GestorEtapa.current_etapa[GestorEtapa.etapa_actual-1]] == GestorEtapa.kill_count:
		if GestorEtapa.etapa_actual == 8 and GestorEtapa.boss_defeatd == true: return
		else:
			next_zone.visible = true
			next_zone_sounds()
	else:
		next_zone.visible = false
		play_next_zone_sounds = false
	waves.text = str(GestorEtapa.kill_count) + "/" + str(GestorEtapa.threshold_etapas[GestorEtapa.current_etapa[GestorEtapa.etapa_actual-1]])

## public methods
func next_zone_sounds() -> void: 
	if play_next_zone_sounds: return
	Audio.can_zone_up()
	play_next_zone_sounds = true

## private methods
