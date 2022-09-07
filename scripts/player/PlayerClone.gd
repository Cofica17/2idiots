extends KinematicBody
class_name PlayerClone

onready var animation_tree := $AnimationTree

var user_id
var basic_attack:BasicAttack#Speed and damage should be set by server
var aim_point

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

func get_aim_point():
	return aim_point

#TODO: REFACTOR TO BE SERVER-SIDE
func _on_Area_body_entered(body):
	if body.is_in_group("DamageDealer"):
		Server.send_damage(5)

func _on_Area_area_entered(area):
	if area.get_parent().is_in_group("DamageDealer"):
		Server.send_damage(5)

func set_health(health):
	$Health.text = str(health)
