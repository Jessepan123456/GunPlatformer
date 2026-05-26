class_name Interact_box extends Area2D

##Means what in that range
var current_range = null
var a_machine : bool = false
var pickup : bool = false

##Signal
signal Ammo_reset

func _ready() -> void:
	area_entered.connect( entered_pick_range )
	area_exited.connect( exited_pick_range )
	
func entered_pick_range( i : Area2D ) -> void:
	if i is PickUp:
		current_range = i
		pickup = true
	if i is Ammo_Machine:
		current_range = i
		a_machine = true
		
func exited_pick_range( i : Area2D ) -> void:
	if i is PickUp:
		current_range = null
		pickup = false
	if i is Ammo_Machine:
		current_range = null
		a_machine = true

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		if current_range && pickup == true:
			current_range.picked_up()
		if current_range && a_machine == true:
			Ammo_reset.emit()
		
