extends CanvasLayer

@onready var ammo: Label = $Control/AMMO
@onready var hp: Label = $Control/HP
@onready var hotbar: HotBar = $Control/Hotbar

var player

func _ready() -> void:
	hotbar.slot_selected.connect( _selected )

func _process(_delta: float) -> void:
	ammo.text = str(GameManager.player_total_ammo) + "/" + str(GameManager.player_ammo)

func update_hp_ui( h : int ) -> void:
	hp.text = "HP: " + str(h)
	pass
	
func set_hp( h : int ) -> void:
	hp.text = "HP: " + str(h)
	pass
	
func set_player( p : Player ) -> void:
	player = p

func _selected( index : int ) -> void:
	player.equip( index )
	
