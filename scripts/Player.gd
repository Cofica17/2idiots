extends KinematicBody
class_name Player

#Onreadys
onready var model = $Model
onready var camera = $Camera
onready var animation_player:AnimationPlayer = $AnimationPlayer

var player_locomotion = PlayerLocomotion.new(self as KinematicBody)
var velocity = Vector3.ZERO
#Movement
export var running_speed = 15
export var walking_speed = 8
export var crouch_speed = 3
export var stopping_speed_ground = 0.2
export var stopping_speed_slide = 0.01
export var slide_idle_treshold = 3
var can_sprint = true
#Stamina
export var stamina = 100
export var required_sprint_stamina = 1
export var max_stamina = 100
export var stamina_loss = 0.5
export var stamina_gain = 0.1
export var sprint_stamina_treshold = 20
var stamina_treshold_reached = true
#Jumping
export var jump_strength = 30
var is_double_jumping = false
var is_jumping = false
#Dash
export var dash_idle_treshold = 5
export var dash_move_forward = 200
var can_dash = false
var required_dash_stamina = 25
var dash_stopping_speed = 0.2
#Camera movement
export var turn_angle = 0.05
#Environment
export var gravity = Vector3(0, -70, 0)

func _ready():
	player_locomotion.set_state(player_locomotion.idle)

func _physics_process(delta):
	apply_gravity(delta)
	apply_stamina() 
	player_locomotion._physics_process()
	velocity = move_and_slide(velocity, Vector3.UP)

func change_stamina(v):
	stamina += v

func apply_gravity(delta) -> void:
	velocity += gravity * delta

func apply_stamina() -> void:
	if stamina >= sprint_stamina_treshold:
		stamina_treshold_reached = true
		
	if stamina < max_stamina:
		change_stamina(stamina_gain)

func get_can_sprint() -> bool:
	if stamina < required_sprint_stamina:
		stamina_treshold_reached = false
		return false
	if stamina_treshold_reached:
		return true	
	return false
		
func get_can_dash() -> bool:
	return required_dash_stamina < stamina 

