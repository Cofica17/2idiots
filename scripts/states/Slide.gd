extends State
class_name Slide

func enter():
	.enter()
	play_animation(LocomotionStates.ANIMATIONS.SLIDE)

func get_class() -> String: return "Slide"

func _physics_process():
	._physics_process()
	player.velocity = lerp(player.velocity, Vector3.ZERO, player.stopping_speed_slide)
	
	if player.velocity.length() < player.slide_idle_treshold:
		if is_crouch():
			locomotion.set_crouch_state()
			return
		elif is_forward() or is_back():
			locomotion.set_walk_state()
			return
		else:
			locomotion.set_idle_state()
			return
	if is_jump():
		locomotion.set_jump_state()
		return

func exit():
	.exit()
