extends State
class_name Walk

func enter():
	.enter()

func get_class() -> String: return "Walk"

func _physics_process():
	._physics_process()
	
	if is_jump():
		locomotion.set_jump_state()
	if is_crouch():
		locomotion.set_crouch_state()
	if is_dash() and player.can_dash:
		locomotion.set_dash_state()
	if is_sprint() and not is_back():
		locomotion.set_run_state()
	
	if is_forward():
		play_animation("slow_run")
		move_forward(player.walking_speed)
	elif is_back():
		play_animation("walk_back")
		move_back(player.walking_speed/2)
	elif is_left():
		play_animation("walk_left")
		move_left(player.walking_speed)
	elif is_right():
		play_animation("walk_right")
		move_right(player.walking_speed)
	else:
		locomotion.set_idle_state()

func exit():
	.exit()
