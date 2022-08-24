extends State
class_name Walk

func enter():
	.enter()
	play_animation("running")
	print("Walk")

func _physics_process():
	._physics_process()
	
	if is_sprint() and not is_back() and player.can_sprint:
		locomotion.set_run_state()
	if is_jump():
		locomotion.set_jump_state()
	if is_crouch():
		locomotion.set_slide_state()
	
	if is_forward():
		move_forward(player.walking_speed)
	elif is_back():
		move_back(player.walking_speed)
	else:
		locomotion.set_idle_state()
	
	if Input.is_action_pressed(MOVE_LEFT):
		turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()

func exit():
	.exit()
