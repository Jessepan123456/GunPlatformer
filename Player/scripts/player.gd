class_name Player extends CharacterBody2D

@export var Jump_force : int = 500
@export var speed : int = 200

@onready var state_machine: State_Machine = $Statemachine

func _ready() -> void:
	state_machine.Initailize(self)

## Movement/Gravity
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction = Input.get_axis("Left","Right")
	velocity.x = direction * speed
	
	if Input.is_action_just_pressed("Jump") && is_on_floor():
		velocity.y = -Jump_force 
	move_and_slide()
