class_name Player extends CharacterBody2D

@export var Jump_force : int = 500
@export var speed : int = 200
@onready var animation_player: AnimationPlayer = $Animation/AnimationPlayer

@onready var state_machine: State_Machine = $Statemachine

var jumped : bool = false
var falling : bool = false

func _ready() -> void:
	state_machine.Initailize(self)

## Movement/Gravity
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction = Input.get_axis("Left","Right")
	print(direction)
	
	velocity.x = direction * speed
	move_and_slide()
