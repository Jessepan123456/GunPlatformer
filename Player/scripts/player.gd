class_name Player extends CharacterBody2D

##Player movement
@export var Jump_force : int = 500
@export var speed : int = 200
@export var hp : int = 6

##Player States
@onready var animation_player: AnimationPlayer = $Animation/AnimationPlayer
@onready var state_machine: State_Machine = $Statemachine

##Guns
@export var Guns : Array[PackedScene] = []
@onready var holder: Node2D = $Holder
var equipped : bool = false
var selected_slot := -1
var equipped_slot : = -1

var jumped : bool = false
var falling : bool = false

## Boxes
@onready var hurtbox: HurtBox = $Hurtbox

func _ready() -> void:
	#Set up
	state_machine.Initailize(self)
	GameManager.player = self
	hurtbox.damaged.connect( take_damage )
	PlayerHub.set_hp(hp)
	PlayerHub.set_player(self)
	
	pass

#func _process(_delta: float) -> void:
	##print(gun_holder.current_gun.shoot())
	
## Movement/Gravity
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction = Input.get_axis("Left","Right")
	
	velocity.x = direction * speed
	move_and_slide()
	
##Player Input
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Equip"):
		if selected_slot == -1:
			return
		if selected_slot == equipped_slot:
			return
		equip_weapon( selected_slot )
	elif equipped == true:
		if Input.is_action_just_pressed("Shoot"):
			holder.current_gun.shoot()
		if Input.is_action_just_pressed("reload"):
			holder.current_gun.reload()
		if Input.is_action_just_pressed("unequip"):
			unequip()

##HP 
func take_damage( d : HitBox ) -> void:
	if hp <= 0:
		GameManager.respawn()
		hp = 6
		PlayerHub.update_hp_ui(hp)
	else:
		update_hp(d)
	pass

func update_hp( d : HitBox ) -> void:
	hp -= d.damage
	PlayerHub.update_hp_ui(hp)
	
## Equip
func on_slot_selected( index : int ) -> void:
	selected_slot = index
	if equipped == true:
		unequip()
	
func equip_weapon( index : int ) -> void:
	if index < 0 or index >= Guns.size():
		return
		
	equipped_slot = index

	holder.set_gun(Guns[index])
	holder.current_gun.set_ammo_count()
	equipped = true
	pass

func unequip() -> void:
	holder.remove_gun()
	equipped = false
	equipped_slot = -1
	pass
