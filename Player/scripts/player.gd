class_name Player extends CharacterBody2D

##Player movement
@export var Jump_force : int = 450
@export var speed : int = 200

##Player States
@onready var animation_player: AnimationPlayer = $Animation/AnimationPlayer
@onready var state_machine: State_Machine = $Statemachine
@onready var player_sprite: Sprite2D = $PlayerSprite

##Guns
@onready var holder: Node2D = $Holder
var equipped : bool = false
var selected_slot := -1
var equipped_slot := -1
var is_gun := false

##Movement
var jumped : bool = false
var falling : bool = false
var died : bool = false
var rolling : bool = false

##Allow the Player can or 
var can_move : bool = true
var can_hit : bool = true
var knocked : bool = false

## Boxes
@onready var hurtbox: HurtBox = $Hurtbox
@onready var interaction_box: Interact_box = $InteractionBox

func _ready() -> void:
	#Set up
	state_machine.Initailize(self)
	GameManager.player = self
	PlayerManager.player = self
	if can_hit == true:
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
	
	if knocked == false && can_move && rolling == false:
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
				holder.current_item.use(equipped_slot)
				if holder.current_item.used == true:
					unequip()
		if Input.is_action_just_pressed("reload"):
			if !PlayerManager.Inventory[equipped_slot].type == ItemData.ItemType.GUN:
				return
			if PlayerManager.player_total_magazine <= 0:
				return
			holder.current_item.reload()
		if Input.is_action_just_pressed("unequip"):
			unequip()

##HP 
func take_damage( d : HitBox ) -> void:
	if PlayerManager.hp <= 1:
		update_hp(d)
		died = true
		can_hit = false
		await get_tree().create_timer(2).timeout
		GameManager.respawn()
		hurtbox.set_deferred("monitorable", false)
	else:
		knocked = true
		var knock_dir = sign(global_position.x - d.global_position.x)
		velocity.x += knock_dir * 300

		$".".modulate = Color.RED
		await get_tree().create_timer(0.2).timeout
		$".".modulate = Color.WHITE
		update_hp(d)
	knocked = false
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
	
func is_slot_empty( i : int) -> bool:
	if PlayerManager.Inventory[i] != null:
		return false
	return true
