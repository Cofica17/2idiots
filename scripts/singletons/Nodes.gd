extends Node

onready var player = get_node("/root/Game/Players/Player")

func _ready():
	pass
	
func get_player() -> KinematicBody:
	return player
