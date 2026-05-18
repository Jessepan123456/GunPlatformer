class_name State_Idle extends State

@onready var move: State_Move = $"../Move"
@onready var jump: State_Jump = $"../Jump"
@onready var shoot: State_Shoot = $"../Shoot"
@onready var reload: State_Reload = $"../Reload"

## What happens when the player enters this sdtate
func enter() -> void:
	print("Idle")
	player.jumped = false
	pass

## What happen when the player exits this state
func exit() -> void:
	pass
	
## What happen during the _process update in this state
func Process( _delta : float) -> State:
	if abs(player.velocity.x) > 0.1:
		return move
	
	return null
	
## What happen during the _physics_process update in this State
func Physics( _delta : float) -> State:
	return null
	
## What happen with input events in this state
func HandleInput( _event : InputEvent) -> State:
	if Input.is_action_just_pressed("Jump") && player.is_on_floor():
		player.velocity.y = -player.Jump_force 
		return jump
	if player.equipped == true:
		if Input.is_action_just_pressed("Shoot"):
			return shoot
		if Input.is_action_just_pressed("reload"):
			return reload
	return null
	
