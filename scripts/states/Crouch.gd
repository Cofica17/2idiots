extends State
class_name Crouch

func enter():
	.enter()
	min_recoil = 0
	play_animation("crouch_idle")

func get_class() -> String: return "Crouch"

func _physics_process():
	._physics_process()
	if is_auto_attack():
		player.player_attack.attack()
		
	if not Input.is_action_pressed(CROUCH):
		locomotion.set_idle_state()
		
	if is_forward():
		max_recoil = 4
		play_animation("crouch")
		move_forward(player.crouch_speed)
	elif is_back():
		max_recoil = 4
		play_animation("crouch")
		move_back(player.crouch_speed)
	else:
		if locomotion.state_machine.get_current_node() != "crouch_idle":
			play_animation("crouch_idle")
			min_recoil = 0
		player.velocity = lerp(player.velocity, Vector3.ZERO, player.stopping_speed_ground)

func exit():
	.exit()
