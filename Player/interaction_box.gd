class_name Interact_box extends Area2D

var current_range = null

func _ready() -> void:
	area_entered.connect( entered_pick_range )
	area_exited.connect( exited_pick_range )
	
func entered_pick_range( i : Area2D ) -> void:
	if i is PickUp:
		current_range = i
		
func exited_pick_range( i : Area2D ) -> void:
	if i is PickUp:
		current_range = null

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		if current_range:
			current_range.picked_up()
