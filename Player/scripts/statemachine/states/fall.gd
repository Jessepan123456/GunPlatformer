class_name State_Fall extends State

@onready var idle: State_Idle = $"../Idle"
@onready var move: State_Move = $"../Move"

## What happens when the player enters this state
func enter() -> void:
	player.falling = true
	pass

## What happen when the player exits this state
func exit() -> void:
	pass
	
## What happen during the _process update in this state
func Process( _delta : float) -> State:
	if player.is_on_floor():
		player.falling = false
		if abs(player.velocity.x) > 0.1:
			return move
		else:
			return idle
	return null
	
## What happen during the _physics_process update in this State
func Physics( _delta : float) -> State:
	return null
	
## What happen with input events in this state
func HandleInput( _event : InputEvent) -> State:
	return null
