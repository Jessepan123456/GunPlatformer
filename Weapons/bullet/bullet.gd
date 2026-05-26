extends CharacterBody2D

@export var speed : int = 800
@onready var sprite: Sprite2D = $Sprite2D
var direction := Vector2.RIGHT
var life_span : float

@onready var hitbox: HitBox = $Hitbox

func _ready() -> void:
	hitbox.entered.connect( remove_bullet )

func _physics_process(_delta: float) -> void:
	velocity = direction * speed 
	sprite.rotation = direction.angle()
	move_and_slide()
	
	## if it hits a collision box 
	var collision = move_and_collide(direction * speed * _delta) 
	
	## If it hits a wall
	if get_slide_collision_count() > 0:
		queue_free()

func _process(delta: float) -> void:
	life_span -= delta
	
	if life_span <= 0:
		queue_free()

func remove_bullet() -> void:
	queue_free()
	pass

func set_life_span( i : float ) -> void:
	life_span = i
	pass
