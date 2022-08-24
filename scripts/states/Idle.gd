extends State
class_name Idle

func init(_player, _locomotion):
	.init(_player, _locomotion)
	print("Idle")

func _physics_process():
	if player.is_on_floor():
		if (Input.is_action_pressed(MOVE_FORWARD) or Input.is_action_pressed(MOVE_BACK)) and Input.is_action_pressed(SPRINT) and player.can_sprint:
			locomotion.set_run_state()
		elif (Input.is_action_pressed(MOVE_FORWARD) or Input.is_action_pressed(MOVE_BACK)) and (!Input.is_action_pressed(SPRINT) or !player.can_sprint):
			locomotion.set_walk_state()
		elif Input.is_action_just_pressed(JUMP):
			locomotion.set_jump_state()
	
	player.velocity = lerp(player.velocity, Vector3.ZERO, player.stopping_speed_ground)
	
	if Input.is_action_pressed(MOVE_LEFT):
		turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()

func exit():
	pass
