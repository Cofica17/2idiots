extends Node

onready var player = get_node("/root/Game/Players/Player")
onready var ui = get_node("/root/Game/UI")

func _ready():
	pass
	
func get_player() -> KinematicBody:
	return player

func get_ui() -> Control:
	return ui
