class_name State

var player:KinematicBody
var locomotion
var locomotion_state

const MOVE_FORWARD = "move_forward"
const MOVE_BACK = "move_back"
const MOVE_LEFT = "move_left"
const MOVE_RIGHT = "move_right"
const JUMP = "jump"
const SPRINT = "sprint"
const CROUCH = "crouch"
const DASH = "dash"
const SLIDE = "slide"

func init(_player, _locomotion):
	player = _player
	locomotion = _locomotion

func enter():
	pass

func get_class():
	pass

func _physics_process():
	pass

func exit():
	pass

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

func play_animation(anim):
	if locomotion.state_machine.get_current_node() == anim:
		return
	
	Server.send_player_animation(anim)
	locomotion.state_machine.travel(anim)

func move_forward(speed):
	player.velocity = player.global_transform.basis.z * speed

func move_back(speed):
	player.velocity = -player.global_transform.basis.z * speed

func move_left(speed):
	player.velocity = player.global_transform.basis.x * speed

func move_right(speed):
	player.velocity = -player.global_transform.basis.x * speed

#func turn_left():
#	player.rotate_y(player.turn_angle)
#
#func turn_right():
#	player.rotate_y(-player.turn_angle)
