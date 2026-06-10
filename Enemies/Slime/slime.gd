class_name Slime extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: HurtBox = $Hurtbox
@onready var right_ray_cast: RayCast2D = $RightRayCast2D
@onready var left_ray_cast: RayCast2D = $LeftRayCast2D

@export var hp := 2
@export var SPEED = 60

var direction = 1

func _ready() -> void:
	hurtbox.damaged.connect( take_damage )
	
func take_damage( d : HitBox ) -> void:
	$AnimatedSprite2D.play("damaged")
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("default")
	hp -= 1
	if hp == 0:
		queue_free()

##help detected when the ray case touch something
func _process(delta: float) -> void:
	if right_ray_cast.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if left_ray_cast.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta
