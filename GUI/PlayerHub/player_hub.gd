extends CanvasLayer

@onready var label: Label = $Control/Label

func _process(_delta: float) -> void:
	label.text = str(GameManager.player_total_ammo) + "/" + str(GameManager.player_ammo)
