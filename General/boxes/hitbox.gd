class_name HitBox extends Area2D

@export var damage : int = 1

signal entered

func _ready() -> void:
	area_entered.connect( Entered )
	
func Entered( area : Area2D ) -> void:
	if area is HurtBox:
		entered.emit()
		area.take_damage( self )
	
