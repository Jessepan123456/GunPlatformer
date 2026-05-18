class_name State_Shoot extends State

@onready var move: State_Move = $"../Move"
@onready var idle: State_Idle = $"../Idle"

## What happens when the player enters this state
func enter() -> void:
	print("Shoot")
	#Shoot your bullet and wait then go to next state
	pass

## What happen when the player exits this state
func exit() -> void:
	pass
	
## What happen during the _process update in this state
func Process( _delta : float) -> State:
	if abs(player.velocity.x) > 0.1:
		return move
	else:
		return idle
	
## What happen during the _physics_process update in this State
func Physics( _delta : float) -> State:
	return null
	
## What happen with input events in this state
func HandleInput( _event : InputEvent) -> State:
	return null
	
