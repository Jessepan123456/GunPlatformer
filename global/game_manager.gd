extends Node

var respawn_point : Vector2 = Vector2.ZERO
var player : Node = null

func respawn() -> void:
	if player:
		player.global_position = respawn_point
