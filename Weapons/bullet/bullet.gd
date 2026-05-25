extends CharacterBody2D

@export var speed : int = 800
@onready var sprite: Sprite2D = $Sprite2D
var direction := Vector2.RIGHT

@onready var hitbox: HitBox = $Hitbox

func _ready() -> void:
	hitbox.entered.connect( remove_bullet )

func _physics_process(_delta: float) -> void:
	velocity = direction * speed 
	sprite.rotation = direction.angle()
	move_and_slide()
	
	var collision = move_and_collide(direction * speed * _delta) 
	
	if get_slide_collision_count() > 0:
		queue_free()

func remove_bullet() -> void:
	queue_free()
	pass
