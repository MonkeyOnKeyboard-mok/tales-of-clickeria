extends Node

## Enemy Signals

@warning_ignore("unused_signal")
signal enemy_died

## UI Signals

@warning_ignore("unused_signal")
signal update_passives(type: String, effect: String, value: float)

## Main Signals

@warning_ignore("unused_signal")
signal spawn_enemy
@warning_ignore("unused_signal")
signal spawn_minion
@warning_ignore("unused_signal")
signal spawn_hourglass
@warning_ignore("unused_signal")
signal spawn_cuadrante_potion
@warning_ignore("unused_signal")
signal upgrade_chosen
@warning_ignore("unused_signal")
signal pause_game

## Particle Signals
@warning_ignore("unused_signal")
signal spawn_particle(pos: Vector2)

## Player Signals
@warning_ignore("unused_signal")
signal gain_juice(amount : float)
@warning_ignore("unused_signal")
signal check_juice(amount : float)
@warning_ignore("unused_signal")
signal spent_juice(amount : float, item: String, minion_type: String)
@warning_ignore("unused_signal")
signal gained_experience(amount : float)
@warning_ignore("unused_signal")
signal player_gained_health(amount : float)
@warning_ignore("unused_signal")
signal player_leveled_up

## Shop Signals
@warning_ignore("unused_signal")
signal update_price


## Minions 

## Minion Types - Packed Scenes - Constants
const MINION_TYPES = {
	"fire": preload("uid://c6758l4ovsyf1"),
	"light": preload("uid://bg5nnqgeloj4y"),
	"cold":	preload("uid://bpuuyd5t8a32p")
}
