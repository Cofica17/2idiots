extends State
class_name Run

func enter():
	.enter()
	play_animation("run")

func get_class() -> String: return "Run"

func _physics_process():
	._physics_process()
	
	if Input.is_action_just_pressed(DASH) and player.get_can_dash():
		locomotion.set_dash_state()
	if is_jump():
		locomotion.set_jump_state()
	if is_crouch():
		locomotion.set_slide_state()
	if not is_sprint():
		locomotion.set_walk_state()
		
	if is_forward():
		if player.get_can_sprint():
			player.change_stamina(-player.stamina_loss)
			move_forward(player.running_speed)
		else:
			locomotion.set_walk_state()
	else:
		locomotion.set_idle_state()

func exit():
	.exit()
