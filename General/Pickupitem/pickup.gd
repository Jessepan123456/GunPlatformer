class_name PickUp extends Area2D

@export var item_texture : Texture2D
@export var item : ItemData

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	sprite_2d.texture = item_texture
	animation_player.play("on_ground")
	pass

##What happen when you pick up the item
func picked_up() -> void:
	var index = get_first_empty_slot()
	PlayerManager.Inventory[index] = item
	add_icon(index)
	queue_free()

##Get the first slot so it moves over and not overlap
func get_first_empty_slot() -> int:
	for i in range(PlayerManager.Inventory.size()):
		if PlayerManager.Inventory[i] == null:
			return i
	return -1
	
##Images for each slot when pick up
func add_icon( i : int ) -> void:
	if i == -1:
		return
	
	PlayerHub.set_slot_icon(i, PlayerManager.Inventory[i].icon)
	
