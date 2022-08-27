extends Node
class_name PlayerAttack

var projectile_number = 1
var projectile = load("res://scenes/AutoAttack.tscn")
var projectile_instance
var player:KinematicBody
var player_camera = null
var bullet_direction = null

func _init(_player):
	player = _player

func get_player_aim() -> void:
	player_camera = player.camera_controller
	bullet_direction = player_camera.get_bullet_direction()
	
func attack() -> void:
	get_player_aim()
	projectile_instance = projectile.instance()
	projectile_instance.set_bullet_direction(bullet_direction)
	projectile_instance.translation = Vector3.ZERO + Vector3(0.5,0.5,0.5)
	player.add_child(projectile_instance)
