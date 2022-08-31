extends State
class_name Slide

func enter():
	.enter()
	set_recoil(5,9)
	play_animation("slide")

func get_class() -> String: return "Slide"

func _physics_process():
	._physics_process()
	player.velocity = lerp(player.velocity, Vector3.ZERO, player.stopping_speed_slide)
	
	if is_auto_attack():
		player.player_attack.attack()
		
	if player.velocity.length() < player.slide_idle_treshold:
		if is_crouch():
			locomotion.set_crouch_state()
		elif is_forward() or is_back():
			locomotion.set_walk_state()
		else:
			locomotion.set_idle_state()
	if is_jump():
		locomotion.set_jump_state()

func exit():
	.exit()
