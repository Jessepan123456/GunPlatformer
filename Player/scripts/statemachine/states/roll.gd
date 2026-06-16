class_name State_Roll extends State

@onready var move: State_Move = $"../Move"
@onready var idle: State_Idle = $"../Idle"

var roll_time := 0.0
var facing_dir := 0.0

## What happens when the player enters this state
func enter() -> void:
	player.rolling = true
	roll_time = 0.0
	facing_dir = Input.get_axis("Left", "Right")
	pass

## What happen when the player exits this state
func exit() -> void:
	pass
	
## What happen during the _process update in this state
func Process( _delta : float) -> State:
	roll_time += _delta
	
	player.velocity.x = facing_dir * 300
	if roll_time >= 1.0:
		if abs(player.velocity.x) > 0.1:
			return move
		if player.velocity == Vector2.ZERO:
			return idle
	return null
	
## What happen during the _physics_process update in this State
func Physics( _delta : float) -> State:
	return null
	
## What happen with input events in this state
func HandleInput( _event : InputEvent) -> State:
	return null
