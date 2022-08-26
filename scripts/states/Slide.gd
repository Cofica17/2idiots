extends State
class_name Slide

func enter():
	.enter()
	play_animation("slide")
	print("Slide")

func _physics_process():
	._physics_process()
	player.velocity = lerp(player.velocity, Vector3.ZERO, 0.02)
	
	if player.velocity.length() < player.slide_idle_treshold:
		if is_forward() or is_back():
			locomotion.set_walk_state()
		else:
			locomotion.set_idle_state()
	if is_jump():
		locomotion.set_jump_state()

func exit():
	.exit()
