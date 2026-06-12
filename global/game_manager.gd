extends Node

var respawn_point : Vector2 = Vector2.ZERO
var player : Node = null

func respawn() -> void:
	if player:
		player.global_position = respawn_point
		player.died = false
		player.can_hit = true

		PlayerManager.hp = 6
		PlayerHub.update_hp_ui(PlayerManager.hp)
