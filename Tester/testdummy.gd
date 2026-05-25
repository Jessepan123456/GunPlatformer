extends Node2D

@onready var hurtbox: HurtBox = $Hurtbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hurtbox.damaged.connect( take_damage )
	
func take_damage( d : HitBox ) -> void:
	$DamageNumberSpawner.spawn_label(d.damage)
	animation_player.play("hitted")
