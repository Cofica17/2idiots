extends State
class_name Run

func enter():
	.enter()
	#Play animation
	print("Run")

func _physics_process():
	._physics_process()
	
	if is_dash() and player.can_dash:
		locomotion.set_dash_state()
	if is_jump():
		locomotion.set_jump_state()
	if is_crouch():
		locomotion.set_slide_state()
	
	if not is_sprint():
		locomotion.set_walk_state()
	
	print(player.is_on_floor())
	if is_forward() and player.is_on_floor():
		if player.can_sprint:
			player.change_stamina(-player.stamina_loss)
			move_forward(player.running_speed)
		else:
			locomotion.set_walk_state()
	else:
		locomotion.set_idle_state()
	
	if Input.is_action_pressed(MOVE_LEFT):
		turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()

func exit():
	.exit()
