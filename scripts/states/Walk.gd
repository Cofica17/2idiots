extends State
class_name Walk

func enter():
	.enter()

func get_class() -> String: return "Walk"

func _physics_process():
	._physics_process()
	
	if is_jump():
		locomotion.set_jump_state()
		return
	if is_crouch():
		locomotion.set_crouch_state()
		return
	if is_dash() and player.can_dash:
		locomotion.set_dash_state()
		return
	if is_sprint() and not is_back() and not is_left() and not is_right():
		locomotion.set_run_state()
		return
	
	if is_forward():
		play_animation(LocomotionStates.ANIMATIONS.SLOW_RUN)
		move_forward(player.walking_speed)
	elif is_back():
		play_animation(LocomotionStates.ANIMATIONS.WALK_BACK)
		move_back(player.walking_speed/2)
	elif is_left():
		play_animation(LocomotionStates.ANIMATIONS.WALK_LEFT)
		move_left(player.walking_speed)
	elif is_right():
		play_animation(LocomotionStates.ANIMATIONS.WALK_RIGHT)
		move_right(player.walking_speed)
	else:
		locomotion.set_idle_state()
		return

func exit():
	.exit()
