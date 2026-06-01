class_name Player extends CharacterBody2D

##Player movement
@export var Jump_force : int = 500
@export var speed : int = 200

##Player States
@onready var animation_player: AnimationPlayer = $Animation/AnimationPlayer
@onready var state_machine: State_Machine = $Statemachine

##Guns
@onready var holder: Node2D = $Holder
var equipped : bool = false
var selected_slot := -1
var equipped_slot := -1
var is_gun := false

var jumped : bool = false
var falling : bool = false

## Boxes
@onready var hurtbox: HurtBox = $Hurtbox
@onready var interaction_box: Interact_box = $InteractionBox

func _ready() -> void:
	#Set up
	state_machine.Initailize(self)
	GameManager.player = self
	PlayerManager.player = self
	
	hurtbox.damaged.connect( take_damage )
	interaction_box.Ammo_reset.connect( reset_ammo )
	
	PlayerHub.set_hp(PlayerManager.hp)
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
		use( selected_slot )
	elif equipped == true:
		if Input.is_action_just_pressed("Use"):
			if PlayerManager.Inventory[equipped_slot].type == ItemData.ItemType.GUN:
				holder.current_item.shoot()
			else:
				if !holder.current_item:
					return
				holder.current_item.use()
		if Input.is_action_just_pressed("reload"):
			if !PlayerManager.Inventory[equipped_slot].type == ItemData.ItemType.GUN:
				return
			if PlayerManager.player_total_magazine <= 0:
				return
			holder.current_gun.reload()
		if Input.is_action_just_pressed("unequip"):
			unequip()

##HP 
func take_damage( d : HitBox ) -> void:
	if PlayerManager.hp <= 0:
		GameManager.respawn()
		PlayerManager.hp = 6
		PlayerHub.update_hp_ui(PlayerManager.hp)
	else:
		update_hp(d)
	pass

func update_hp( d : HitBox ) -> void:
	PlayerManager.hp -= d.damage
	PlayerHub.update_hp_ui(PlayerManager.hp)
	
## Equip
func on_slot_selected( index : int ) -> void:
	selected_slot = index
	if equipped == true:
		unequip()
	
func use( index : int ) -> void:
	if index < 0 or index >= PlayerManager.Inventory.size():
		return
		
	equipped_slot = index
	
	if PlayerManager.Inventory[index] == null:
		return
	holder.set_item(PlayerManager.Inventory[index].scene)
	if PlayerManager.Inventory[index].type == ItemData.ItemType.GUN:
		holder.current_item.set_ammo_count()
	equipped = true
	pass

func unequip() -> void:
	holder.remove_item()
	equipped = false
	equipped_slot = -1
	pass

func reset_ammo() -> void:
	if holder.current_item == null:
		return
	holder.current_item.reset()
