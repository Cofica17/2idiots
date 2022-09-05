extends KinematicBody

onready var animation_tree := $AnimationTree

var user_id
var basic_attack:BasicAttack#Speed and damage should be set by server

func _ready():
	#GetFrom server which basic to set
	basic_attack = preload("res://spells/basics/sword_shot/SwordShot.tscn").instance()
	add_child(basic_attack)

#Get from server
func scope_in():
	basic_attack._on_scope_in(Nodes.player.fov_scope_in_sec)

#Get from server
func scope_out():
	basic_attack._on_scope_out(Nodes.player.fov_scope_out_sec)
