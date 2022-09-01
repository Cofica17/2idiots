class_name State

var player:KinematicBody
var locomotion
var locomotion_state
var last_model_rot = 0
var min_recoil = 2
var max_recoil = 5

const MOVE_FORWARD = "move_forward"
const MOVE_BACK = "move_back"
const MOVE_LEFT = "move_left"
const MOVE_RIGHT = "move_right"
const JUMP = "jump"
const SPRINT = "sprint"
const CROUCH = "crouch"
const DASH = "dash"
const SLIDE = "slide"
const AUTO_ATTACK = "auto_attack"
const SCOPE = "scope"

func init(_player, _locomotion):
	player = _player
	locomotion = _locomotion

func enter():
	pass

func get_class():
	pass

func _physics_process():
	if is_scope_in():
		player.emit_signal("scope_in")
	if is_scope_out():
		player.emit_signal("scope_out")
	pass

func exit():
	pass

func set_recoil(_min, _max):
	min_recoil = _min
	max_recoil = _max

func is_dash() -> bool:
	return Input.is_action_pressed(DASH)

func is_crouch() -> bool:
	return Input.is_action_pressed(CROUCH)

func is_jump() -> bool:
	return Input.is_action_pressed(JUMP)

func is_sprint() -> bool:
	return Input.is_action_pressed(SPRINT)

func is_back() -> bool:
	return Input.is_action_pressed(MOVE_BACK)

func is_right() -> bool:
	return Input.is_action_pressed(MOVE_RIGHT)

func is_left() -> bool:
	return Input.is_action_pressed(MOVE_LEFT)

func is_forward() -> bool:
	return Input.is_action_pressed(MOVE_FORWARD)

func is_auto_attack() -> bool:
	return Input.is_action_just_pressed(AUTO_ATTACK)

func is_direction() -> bool:
	return is_forward() or is_left() or is_right() or is_back()

func is_scope_in() -> bool:
	return Input.is_action_just_pressed(SCOPE)
	
func is_scope_out() -> bool:
	return Input.is_action_just_released(SCOPE)

func play_animation(anim):
	if player.animation_tree["parameters/state/current"] == anim:
		return
	
	Server.send_player_animation(anim)
	player.animation_tree["parameters/state/current"] = anim

func move(speed, front=true,right=true,back=true,left=true):
	var velocity = Vector3.ZERO
	var model_rot = 0
	
	if front and is_forward():
		velocity += player.global_transform.basis.z * speed
	if right and is_right():
		velocity += -player.global_transform.basis.x * speed
	if back and is_back():
		velocity += -player.global_transform.basis.z * speed
	if left and is_left():
		velocity += player.global_transform.basis.x * speed
	
	if is_forward() and is_left():
		model_rot = 45
	elif is_forward() and is_right():
		model_rot = 315
	elif is_back() and is_left():
		model_rot = 135
	elif is_back() and is_right():
		model_rot = 225
	elif is_left():
		model_rot = 90
	elif is_right():
		model_rot = 270
	elif is_back():
		model_rot = 180
	
	if abs(last_model_rot - model_rot) > 180:
		player.model.rotation_degrees.y -= 360
		if last_model_rot == 0:
			player.model.rotation_degrees.y = 360
		if last_model_rot == 45:
			player.model.rotation_degrees.y = 405
	
	set_player_velocity(velocity)
	player.model.rotation_degrees.y = lerp(player.model.rotation_degrees.y, model_rot, 0.06)
	last_model_rot = model_rot

func move_forward(speed):
	set_player_velocity(player.global_transform.basis.z * speed)

func move_back(speed):
	set_player_velocity(-player.global_transform.basis.z * speed)

func move_left(speed):
	set_player_velocity(player.global_transform.basis.x * speed)

func move_right(speed):
	set_player_velocity(-player.global_transform.basis.x * speed)

func set_player_velocity(velocity):
	var v_y = player.velocity.y
	player.velocity = velocity
	player.velocity.y = v_y
