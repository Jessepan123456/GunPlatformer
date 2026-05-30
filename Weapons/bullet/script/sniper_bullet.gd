extends CharacterBody2D

@export var speed : int = 800
@onready var sprite: Sprite2D = $Sprite2D
var direction := Vector2.RIGHT
var life_span : float

@onready var hitbox: HitBox = $Hitbox

func _physics_process(_delta: float) -> void:
	velocity = direction * speed 
	sprite.rotation = direction.angle()
	move_and_slide()
	
	## If it hits a wall
	if get_slide_collision_count() > 0:
		queue_free()

func _process(delta: float) -> void:
	life_span -= delta
	
	if life_span <= 0:
		queue_free()

func set_life_span( i : float ) -> void:
	life_span = i
	pass
