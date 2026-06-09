class_name HotBar extends HBoxContainer

signal slot_selected(index)

@onready var button: Button = $Button
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3
@onready var button_4: Button = $Button4
@onready var button_5: Button = $Button5
@onready var button_6: Button = $Button6

##Icon slot choices
@onready var icons_slots := [
	$Button/TextureRect,
	$Button2/TextureRect,
	$Button3/TextureRect,
	$Button4/TextureRect,
	$Button5/TextureRect,
	$Button6/TextureRect,
]
var previous_button 

func _ready() -> void:
	previous_button = button
	
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
		emit_button(0, button)
	if Input.is_action_just_pressed("slot_2"):
		emit_button(1, button_2)
	if Input.is_action_just_pressed("slot_3"):
		emit_button(2, button_3)
	if Input.is_action_just_pressed("slot_4"):
		emit_button(3, button_4)
	if Input.is_action_just_pressed("slot_5"):
		emit_button(4, button_5)
	if Input.is_action_just_pressed("slot_6"):
		emit_button(5, button_6)
	 
##Changing the slot change when selected
func emit_button( index : int, B : Button) -> void:
	reset_button(previous_button)
	B.modulate = Color.GRAY
	slot_selected.emit(index)
	previous_button = B
	pass	
	
##Reset the button color
func reset_button( B : Button) -> void:
	B.modulate = Color.WHITE

func set_icon( index : int ,t : Texture2D) -> void:
	icons_slots[index].texture = t

func remove_icon( index : int ) -> void:
	icons_slots[index].texture = null
