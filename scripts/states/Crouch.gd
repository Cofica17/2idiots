extends State
class_name Crouch

func enter():
	.enter()
	set_recoil(0,4)
	play_animation(LocomotionStates.ANIMATIONS.CROUCH_IDLE)

func get_class() -> String: return "Crouch"

func _physics_process():
	._physics_process()
	if is_auto_attack():
		player.player_attack.attack()
		
	if not Input.is_action_pressed(CROUCH):
		locomotion.set_idle_state()
		return
	
	if is_direction():
		set_recoil(2,6)
		play_animation(LocomotionStates.ANIMATIONS.CROUCH)
		move(player.crouch_speed)
	else:
		play_animation(LocomotionStates.ANIMATIONS.CROUCH_IDLE)
		set_recoil(0,4)
		set_player_velocity(lerp(player.velocity, Vector3.ZERO, player.stopping_speed_ground))

func exit():
	.exit()
