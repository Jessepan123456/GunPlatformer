extends Node

var respawn_point : Vector2 = Vector2.ZERO
var player : Node = null

var player_ammo : int
var player_total_ammo : int

func respawn() -> void:
	if player:
		player.global_position = respawn_point

func set_player_ammo( i : int) -> void:
	player_ammo = i
	
func set_player_total_ammo( i : int ) -> void:
	player_total_ammo = i
