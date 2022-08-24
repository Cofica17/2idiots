extends State
class_name Run

func enter():
	.enter()
	play_animation("fast_running")

func _physics_process():
	._physics_process()
	
	if is_jump():
		locomotion.set_jump_state()
	
	if not is_sprint():
		locomotion.set_walk_state()
	if is_forward():
		if player.stamina > 0:
			player.change_stamina(-player.stamina_loss)
		move_forward(player.running_speed)
	else:
		locomotion.set_idle_state()
	
	if Input.is_action_pressed(MOVE_LEFT):
		turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()

func exit():
	.exit()
