extends CharacterBody2D

@export var speed : int = 800
@onready var sprite: Sprite2D = $Sprite2D
var direction := Vector2.RIGHT

func _physics_process(_delta: float) -> void:
	velocity = direction * speed 
	sprite.rotation = direction.angle()
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		queue_free()
