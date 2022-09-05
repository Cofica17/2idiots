extends State
class_name Idle

func enter():
	.enter()
	set_recoil(1,5)
	play_animation(LocomotionStates.ANIMATIONS.IDLE)

func get_class() -> String: return "Idle"

func _physics_process():
	._physics_process()
	
	if is_forward() or is_back() or is_left() or is_right():
		locomotion.set_walk_state()
		return
	if is_jump():
		locomotion.set_jump_state()
		return
	if is_crouch():
		locomotion.set_crouch_state()
		return
	
	set_player_velocity(lerp(player.velocity, Vector3.ZERO, player.stopping_speed_ground))

func exit():
	.exit()
