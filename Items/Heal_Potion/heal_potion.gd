class_name Heal_Potion extends Node2D

var used : bool = false

func use( i : int) -> void:
	if PlayerManager.hp < 6:
		PlayerManager.update_used(i)
		PlayerHub.remove_slot_icon(i)
		PlayerManager.hp += 1
		PlayerHub.update_hp_ui(PlayerManager.hp)
		
		used = true
		queue_free()
	pass
