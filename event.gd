extends Node

## Enemy Signals

@warning_ignore("unused_signal")
signal enemy_died


## Main Signals

@warning_ignore("unused_signal")
signal spawn_enemy
@warning_ignore("unused_signal")
signal spawn_minion
@warning_ignore("unused_signal")
signal spawn_hourglass
@warning_ignore("unused_signal")
signal upgrade_chosen


## Minions 

## Minion Types - Packed Scenes - Constants

const MINION_TYPES = {
	"fire": preload("uid://c6758l4ovsyf1"),
	"light": preload("uid://bg5nnqgeloj4y")
}
