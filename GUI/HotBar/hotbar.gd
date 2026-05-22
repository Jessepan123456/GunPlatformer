class_name HotBar extends HBoxContainer

signal slot_selected(index)

@onready var button: Button = $Button
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3
@onready var button_4: Button = $Button4
@onready var button_5: Button = $Button5
@onready var button_6: Button = $Button6

func _ready() -> void:
	button.pressed.connect( slot_emit.bind(0) )
	button_2.pressed.connect( slot_emit.bind(1) )
	button_3.pressed.connect( slot_emit.bind(2) )
	button_4.pressed.connect( slot_emit.bind(3) )
	button_5.pressed.connect( slot_emit.bind(4) )
	button_6.pressed.connect( slot_emit.bind(5) )
	pass
	
func slot_emit( index : int ):
	slot_selected.emit(index)


func _unhandled_input(_event: InputEvent) -> void:
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
