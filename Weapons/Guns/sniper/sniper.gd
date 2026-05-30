extends Node2D

##Gun Info
@export var bullet_type : PackedScene
@export var gun_stats : GunResource

##For reset purpose
var ammo : int  = 8
var magazine : int = 1

@onready var hole: Node2D = $Hole
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func shoot() -> void:
	if gun_stats.ammo == 0:
		return
	var bullet = bullet_type.instantiate()
	
	get_tree().current_scene.add_child(bullet)
	
	bullet.global_position = hole.global_position
	
	#Particles/Animation
	gpu_particles_2d.restart()
	animation_player.play("Shoot")
	
	bullet.direction = global_transform.x.normalized()
	
	#Guns Stats
	get_parent().get_parent().velocity += -bullet.direction * gun_stats.recoil_strength
	gun_stats.ammo -= 1
	PlayerManager.set_player_ammo(gun_stats.ammo)
	
	bullet.set_life_span(gun_stats.life_span)
	pass

func set_ammo_count() -> void:
	PlayerManager.set_player_total_magazine(gun_stats.magazine)

func reload() -> void:
	#Reload Animation
	animation_player.play("reload")
	
	await get_tree().create_timer(gun_stats.reload_time).timeout
	
	gun_stats.ammo = gun_stats.total_ammo
	PlayerManager.set_player_ammo(gun_stats.ammo)
	PlayerManager.update_player_total_magazine()
	gun_stats.magazine -= 1
	pass
	
func reset() -> void:
	gun_stats.ammo = ammo
	gun_stats.magazine = magazine
	PlayerManager.set_player_ammo(gun_stats.ammo)
	PlayerManager.set_player_total_magazine(gun_stats.magazine)
