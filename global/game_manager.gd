extends Node

var respawn_point : Vector2 = Vector2.ZERO
var player : Node = null
var void_damaged = false

func respawn() -> void:
	if player:
		player.global_position = respawn_point
		player.died = false
		player.can_hit = true
		player.hurtbox.set_deferred("monitorable", true)

		PlayerManager.hp = 6
		PlayerHub.update_hp_ui(PlayerManager.hp)
