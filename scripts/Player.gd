extends KinematicBody
class_name Player

onready var model = $Model
onready var camera = $CameraController/InnerGimbal/Camera
onready var camera_controller = $CameraController
onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var animation_tree:AnimationTree = $AnimationTree

export var debug_infinite_stamina:bool = false
export var running_speed = 15
export var walking_speed = 5
export var crouch_speed = 3
export var stopping_speed_ground = 0.2
export var stopping_speed_slide = 0.02
export var slide_idle_treshold = 5
export var stamina = 100
export var required_sprint_stamina = 1
export var max_stamina = 100
export var stamina_loss = 0.5
export var stamina_gain = 0.1
export var sprint_stamina_treshold = 20
export var jump_strength = 25
export var dash_idle_treshold = 5
export var dash_move_forward = 200
export var required_dash_stamina = 25
export var turn_angle = 0.05
export var gravity = Vector3(0, -70, 0)

var dash_stopping_speed = 0.2
var is_double_jumping = false
var is_jumping = false
var can_sprint = true
var stamina_treshold_reached = true
var player_locomotion = PlayerLocomotion.new(self as KinematicBody)
var player_attack = PlayerAttack.new(self as KinematicBody)
var velocity = Vector3.ZERO

signal attacked

func _ready():
	player_locomotion.state_machine = animation_tree.get("parameters/playback")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player_locomotion.set_state(player_locomotion.idle)

#TODO: move to a better place
func _input(event):
	if Input.is_key_pressed(KEY_ALT):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	apply_gravity(delta)
	apply_stamina() 
	player_locomotion._physics_process()
	velocity = move_and_slide(velocity, Vector3.UP)

func change_stamina(v):
	if debug_infinite_stamina:
		return
	
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
