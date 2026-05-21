class_name HitBox extends Area2D

@export var damage : int = 1

func _ready() -> void:
	area_entered.connect( Entered )
	
func Entered( area : Area2D ) -> void:
	if area is HurtBox:
		area.take_damage( self )
	
