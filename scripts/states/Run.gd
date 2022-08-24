extends State
class_name Run

func init(_player, _locomotion):
	.init(_player, _locomotion)
	print("Run")

func _physics_process():
	if !Input.is_action_pressed(SPRINT):
		locomotion.set_walk_state()
	if Input.is_action_pressed(MOVE_FORWARD):
		move_forward(player.running_speed)
	elif Input.is_action_pressed(MOVE_BACK):
		move_back(player.running_speed)
		locomotion.set_walk_state()
	else:
		locomotion.set_idle_state()
	
	if Input.is_action_pressed(MOVE_LEFT):
		turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()

func exit():
	pass
