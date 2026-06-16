extends Node

@export var animation_tree: AnimationTree
@onready var player : Player = get_owner()

var facing_dir := 1

func _physics_process(_delta: float) -> void:
	if player.velocity.x != 0:
		facing_dir = sign(player.velocity.x)
		
	animation_tree.set("parameters/Move/blend_position", facing_dir)
	animation_tree.set("parameters/Idle/blend_position", facing_dir)
	animation_tree.set("parameters/Jump/blend_position", facing_dir)
	animation_tree.set("parameters/Fall/blend_position", facing_dir)
	animation_tree.set("parameters/Roll/blend_position", facing_dir)
	animation_tree.set("parameters/Death/blend_position", facing_dir)
	
	
