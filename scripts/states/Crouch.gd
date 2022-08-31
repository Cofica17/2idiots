extends State
class_name Crouch

func enter():
	.enter()
	play_animation(LocomotionStates.ANIMATIONS.CROUCH_IDLE)

func get_class() -> String: return "Crouch"

func _physics_process():
	._physics_process()
	
	if not Input.is_action_pressed(CROUCH):
		locomotion.set_idle_state()
		return
	
	if is_forward():
		play_animation(LocomotionStates.ANIMATIONS.CROUCH)
		move_forward(player.crouch_speed)
	elif is_back():
		play_animation(LocomotionStates.ANIMATIONS.CROUCH)
		move_back(player.crouch_speed)
	else:
		play_animation(LocomotionStates.ANIMATIONS.CROUCH_IDLE)
		player.velocity = lerp(player.velocity, Vector3.ZERO, player.stopping_speed_ground)

func exit():
	.exit()
