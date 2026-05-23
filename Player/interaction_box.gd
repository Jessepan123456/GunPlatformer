class_name Interact_box extends Area2D

func _ready() -> void:
	area_entered.connect( pick_range )
	
func pick_range( i : PickUp ) -> void:
	i.picked_up()
