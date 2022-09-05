extends State
class_name Walk

func enter():
	.enter()
	set_recoil(3,7)
	play_animation(LocomotionStates.ANIMATIONS.SLOW_RUN)

func get_class() -> String: return "Walk"

func _physics_process():
	._physics_process()
	
	if is_jump():
		locomotion.set_jump_state()
		return
	if is_crouch():
		locomotion.set_crouch_state()
		return
	if is_dash() and player.get_can_dash():
		locomotion.set_dash_state()
		return
	if is_sprint() and player.get_can_sprint():
		locomotion.set_run_state()
		return
	
	if is_direction():
		move(player.walking_speed)
	else:
		locomotion.set_idle_state()
		return

func exit():
	.exit()
