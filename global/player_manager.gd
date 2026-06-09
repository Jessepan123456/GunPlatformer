extends Node

var Inventory : Array[ItemData] = [null, null, null, null, null, null]
var player : Node = null
var hp : int = 6

## Player Info Update
var player_ammo : int
var player_total_magazine : int

func set_player_ammo( i : int) -> void:
	player_ammo = i
	
func set_player_total_magazine( i : int ) -> void:
	player_total_magazine = i

func update_player_total_magazine() -> void:
	player_total_magazine -= 1
	
func update_used( i : int) -> void:
	Inventory[i] = null
	pass
