extends State
class_name Dash

func enter():
	.enter()
	#Play animation
	print("Dash")

func _physics_process():
	._physics_process()
	if not player.is_dashing:
		player.is_dashing = true
		player.stamina -= player.required_dash_stamina
		move_forward(player.dash_move_forward)
	if player.is_dashing:
		player.velocity = lerp(player.velocity, Vector3.ZERO, player.dash_stopping_speed)
		if player.velocity.length() < player.dash_idle_treshold:
			player.is_dashing = false
			if is_forward() or is_back():
				locomotion.set_walk_state()
			else:
				locomotion.set_idle_state()


func exit():
	.exit()
