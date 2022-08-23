class_name State

var player:KinematicBody
var locomotion
var locomotion_state

const MOVE_FORWARD = "move_forward"
const MOVE_BACK = "move_back"
const MOVE_LEFT = "move_left"
const MOVE_RIGHT = "move_right"

#Always called when state is being transitioned into
func init(_player, _locomotion):
	player = _player
	locomotion = _locomotion

#Here you define any and all behaviors
func _physics_process():
	pass

#Always called when state is being transitioned out off
func exit():
	pass

func move_forward():
	player.velocity = player.global_transform.basis.z * player.running_speed

func move_back():
	player.velocity = -player.global_transform.basis.z * player.running_speed

func turn_left():
	player.rotate_y(player.turn_angle)

func turn_right():
	player.rotate_y(-player.turn_angle)
