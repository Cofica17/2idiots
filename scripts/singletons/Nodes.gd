extends Node

onready var player = get_node("/root/Game/Players/Player")
onready var crosshair = get_node("/root/Game/UI/CrosshairContainer")

func _ready():
	pass
	
func get_player() -> KinematicBody:
	return player

func get_crosshair() -> Control:
	return crosshair
