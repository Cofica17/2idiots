extends State
class_name Crouch

func enter():
	.enter()
	play_animation("crouch_idle")

func get_class() -> String: return "Crouch"

func _physics_process():
	._physics_process()
	if not Input.is_action_pressed(CROUCH):
		locomotion.set_idle_state()
		
	if is_forward():
		play_animation("crouch")
		move_forward(player.crouch_speed)
	elif is_back():
		play_animation("crouch")
		move_back(player.crouch_speed)
	else:
		if locomotion.state_machine.get_current_node() != "crouch_idle":
			play_animation("crouch_idle")
		player.velocity = lerp(player.velocity, Vector3.ZERO, player.stopping_speed_ground)

func exit():
	.exit()
