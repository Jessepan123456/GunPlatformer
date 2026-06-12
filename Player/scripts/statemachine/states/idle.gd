class_name State_Idle extends State

@onready var move: State_Move = $"../Move"
@onready var jump: State_Jump = $"../Jump"
@onready var death: State_Death = $"../Death"

## What happens when the player enters this sdtate
func enter() -> void:
	player.jumped = false
	player.can_move = true
	pass

## What happen when the player exits this state
func exit() -> void:
	pass
	
## What happen during the _process update in this state
func Process( _delta : float) -> State:
	if abs(player.velocity.x) > 0.1:
		return move
	if player.died == true:
		return death
	
	return null
	
## What happen during the _physics_process update in this State
func Physics( _delta : float) -> State:
	return null
	
## What happen with input events in this state
func HandleInput( _event : InputEvent) -> State:
	if Input.is_action_just_pressed("Jump") && player.is_on_floor():
		player.velocity.y = -player.Jump_force 
		return jump
	return null
	
