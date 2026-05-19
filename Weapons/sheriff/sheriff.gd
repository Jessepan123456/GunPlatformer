extends Node2D

##Gun Info
@export var bullet_type : PackedScene
@export var recoil_strength : int = 100
@export var ammo : int = 30
@export var damage : int = 1
var total_ammo : int

@onready var hole: Node2D = $Hole
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func shoot() -> void:
	if ammo == 0:
		return
	var bullet = bullet_type.instantiate()
	
	get_tree().current_scene.add_child(bullet)
	
	bullet.global_position = hole.global_position
	
	#Particles/Animation
	gpu_particles_2d.restart()
	animation_player.play("Shoot")
	
	bullet.direction = global_transform.x.normalized()
	
	#Guns Stats
	get_parent().get_parent().velocity += -bullet.direction * recoil_strength
	ammo -= 1
	GameManager.set_player_ammo(ammo)
	
	pass

func set_ammo_count() -> void:
	total_ammo = ammo
	GameManager.set_player_total_ammo(total_ammo)

func reload() -> void:
	#Reload Animation
	animation_player.play("reload")
	await animation_player.animation_finished
	
	ammo = total_ammo
	GameManager.set_player_ammo(ammo)
	pass
