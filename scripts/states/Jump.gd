extends State
class_name Jump

func enter():
	.enter()
	play_animation(LocomotionStates.ANIMATIONS.JUMP)
	
func get_class() -> String: return "Jump"
	
func _physics_process():
	._physics_process()

	if not player.is_jumping:
		player.is_jumping = true
		player.velocity.y = player.jump_strength
		
	elif player.velocity.y < 0:
		locomotion.set_fall_state()
		return

func exit():
	.exit()
