class_name Heal_Potion extends Node2D

func use() -> void:
	PlayerManager.hp += 1
	PlayerHub.update_hp_ui(PlayerManager.hp)
	queue_free()
	pass
