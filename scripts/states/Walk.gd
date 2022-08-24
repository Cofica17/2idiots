extends State
class_name Walk

func init(_player, _locomotion):
	.init(_player, _locomotion)
	print("Walk")

func _physics_process():
	if Input.is_action_just_pressed(JUMP):
		locomotion.set_jump_state()
	if Input.is_action_pressed(SPRINT) and !Input.is_action_pressed(MOVE_BACK) and player.can_sprint:
		locomotion.set_run_state()
	elif Input.is_action_pressed(MOVE_FORWARD):
		move_forward(player.walking_speed)
	elif Input.is_action_pressed(MOVE_BACK):
		move_back(player.walking_speed)
	else:
		locomotion.set_idle_state()
	
	if Input.is_action_pressed(MOVE_LEFT):
		turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()

func exit():
	pass
