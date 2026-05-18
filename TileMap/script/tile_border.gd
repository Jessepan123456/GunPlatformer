extends Area2D

func _ready() -> void:
	body_entered.connect( respawn )
	
func respawn( _body ) -> void:
	GameManager.respawn()
	pass
