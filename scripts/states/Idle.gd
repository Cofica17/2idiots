extends State
class_name Idle

func init(_player, _locomotion):
	.init(_player, _locomotion)

func _physics_process():
	if Input.is_action_pressed(MOVE_FORWARD) or Input.is_action_pressed(MOVE_BACK):
		locomotion.set_run_state()
	
	player.velocity = lerp(player.velocity, Vector3.ZERO, player.stopping_speed_ground)
	
	if Input.is_action_pressed(MOVE_LEFT):
		turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()

func exit():
	pass
