extends State
class_name Jump

func enter():
	.enter()
	set_recoil(5,9)
	play_animation(LocomotionStates.ANIMATIONS.JUMP)
	
func get_class() -> String: return "Jump"
	
func _physics_process():
	._physics_process()
	
	if is_auto_attack():
		player.player_attack.attack()
		
	if not player.is_jumping:
		player.is_jumping = true
		player.velocity.y = player.jump_strength
		
	elif player.velocity.y < 0:
		locomotion.set_fall_state()
		return
	
	if locomotion.previous_state is Idle or locomotion.previous_state is Walk or locomotion.previous_state is Run:
		var vel = player.walking_speed
		if locomotion.previous_state is Run:
			vel = player.running_speed
		move(vel)

func exit():
	.exit()
