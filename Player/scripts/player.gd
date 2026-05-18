class_name Player extends CharacterBody2D

##Player movement
@export var Jump_force : int = 500
@export var speed : int = 200

##Player States
@onready var animation_player: AnimationPlayer = $Animation/AnimationPlayer
@onready var state_machine: State_Machine = $Statemachine

##Guns
@export var Guns : Array[PackedScene] = []
@onready var gun_holder: Node = $GunHolder
var equipped : bool = false

var jumped : bool = false
var falling : bool = false

func _ready() -> void:
	state_machine.Initailize(self)
	GameManager.player = self
	pass


## Movement/Gravity
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction = Input.get_axis("Left","Right")
	
	velocity.x = direction * speed
	move_and_slide()
	
func _input(_event: InputEvent) -> void:
	if equipped == false:
		if Input.is_action_just_pressed("Equip"):
			equipped = true
			gun_holder.set_gun(Guns[0])
	else:
		if Input.is_action_just_pressed("Equip"):
			equipped = false
			gun_holder.remove_gun()
