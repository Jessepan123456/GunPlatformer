extends Node2D

var current_item : Node2D
var offset := Vector2(0, 0)

func _ready() -> void:
	position = offset

func _process(_delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	look_at(get_global_mouse_position())
	
	if mouse_position.x < global_position.x:
		scale.y = -1
	else:
		scale.y = 1

func set_item( gun_scene : PackedScene ):
	current_item = gun_scene.instantiate()
	add_child(current_item)
	
func remove_item():
	current_item.queue_free()
	

	
