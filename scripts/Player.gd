extends KinematicBody
class_name Player

onready var model = $Model
onready var camera = $Camera

export var character_model:PackedScene = preload("res://assets/characthers/models/godot_models/king.tscn") setget set_character_model
export var running_speed = 10
export var walking_speed = 4
export var stopping_speed_ground = 0.1
export var turn_angle = 0.05
export var gravity = Vector3(0, -70, 0)
export var jump_strength = 10
export var backward_speed_modifier = 0.5
export var required_sprint_stamina = 1

onready var stamina = 100


var player_locomotion = PlayerLocomotion.new(self as KinematicBody)
var is_double_jumping = false
var is_jumping = false
var can_sprint = true

var velocity = Vector3.ZERO

func _ready():
	pass


func set_character_model(v) -> void:
	if not $Model:
		return
	
	character_model = v
	for child in $Model.get_children():
		child.queue_free()
	$Model.add_child(character_model.instance())


func _physics_process(delta):
	apply_gravity(delta)
	apply_stamina() 
	apply_sprint_state()
	player_locomotion._physics_process()
	velocity = move_and_slide(velocity, Vector3.UP)


func apply_gravity(delta) -> void:
	velocity += gravity * delta
	
	
func apply_stamina() -> void:
	if stamina < 100:
		stamina += 0.1
	#print(stamina)
	
	
func apply_sprint_state() -> void:
	if stamina < 1:
		can_sprint = false
	if stamina >= 20:
		can_sprint = true
