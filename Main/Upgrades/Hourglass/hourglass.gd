extends Node
## enums
## consts
## exports
## public vars
var nearest: Node2D = null
var buff_count := 1
var affected_minions: Array[Node2D] = []
var current_pos := Vector2.ZERO
var minions_per_distance: Array = []  # store nodes ordered by distance
## private vars
## onready vars
@onready var minion_manager: Node = get_parent().get_node("MinionManager")
# "obj_" for node references;
## built-in override methods

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	current_pos = self.global_position
	check_proximity()

func push_back() -> void:
	var push_tween = create_tween()
	push_tween.tween_property(self, "global_position" , Vector2(575,480),0.2)

func check_proximity() -> void:
	# Step 1: collect all minions
	var minions: Array[Node2D] = []
	for child in minion_manager.get_children():
		if child is Node2D:
			minions.append(child)
	if minions.is_empty():
		return

	# Step 2: sort by distance
	minions.sort_custom(_sort_by_distance)

	# Step 3: pick the top N nearest
	var new_affected: Array[Node2D] = minions.slice(0, buff_count)
# Step 4: remove buff only from those no longer affected
	for m in affected_minions:
		if not is_instance_valid(m):
			continue  # skip freed minions
		if not new_affected.has(m):
			if m:
				if m.has_method("remove_atk_spd"):
					m.remove_atk_spd()

	# Step 5: apply buff only to newly affected
	for m in new_affected:
		if not affected_minions.has(m):
			if m.has_method("apply_attack_speed_buff"):
				m.apply_attack_speed_buff()

	# Step 6: update the affected set
	affected_minions = new_affected

func _sort_by_distance(a: Node2D, b: Node2D) -> bool:
	return current_pos.distance_to(a.global_position) < current_pos.distance_to(b.global_position)

## public methods

## private methods
