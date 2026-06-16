class_name Grape extends Node2D

@export var heal := 0
var used : bool = false

func use( i : int) -> void:
	if PlayerManager.hp < 6:
		PlayerManager.update_used(i)
		PlayerHub.remove_slot_icon(i)
		PlayerManager.hp += heal
		PlayerHub.update_hp_ui(PlayerManager.hp)
		
		used = true
		queue_free()
	pass
