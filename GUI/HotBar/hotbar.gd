class_name HotBar extends HBoxContainer

signal slot_selected(index)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("slot_1"):
		slot_selected.emit(0)
	if Input.is_action_just_pressed("slot_2"):
		slot_selected.emit(1)
	if Input.is_action_just_pressed("slot_3"):
		slot_selected.emit(2)
	if Input.is_action_just_pressed("slot_4"):
		slot_selected.emit(3)
	if Input.is_action_just_pressed("slot_5"):
		slot_selected.emit(4)
	if Input.is_action_just_pressed("slot_6"):
		slot_selected.emit(5)
