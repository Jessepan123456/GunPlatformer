class_name Ammo_Machine extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	area_entered.connect( entered )
	area_exited.connect( exited )
	
func entered( i : Area2D ) -> void:
	animation_player.play("Interact")
	pass
	
func exited( i : Area2D) -> void:
	animation_player.play("RESET")
	pass 
