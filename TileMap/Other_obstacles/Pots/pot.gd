class_name Pot extends Node2D

@onready var hurtbox: HurtBox = $Hurtbox
@onready var damage_number_spawner: DamageNumberSpawner = $DamageNumberSpawner

@export var hp := 2
@export var pot_texture := Texture2D

func _ready() -> void:
	$Sprite2D.texture = pot_texture
	if hp == 1:
		$Sprite2D.frame = 1
	hurtbox.damaged.connect( take_damage )
	
func take_damage( d : HitBox ) -> void:
	$DamageNumberSpawner.spawn_label(d.damage)
	hp -= 1
	$Sprite2D.frame = 1
	if hp == 0:
		queue_free()
