extends State
class_name Jump

func enter():
	.enter()
	min_recoil = 5
	play_animation("jump")
	
func get_class() -> String: return "Jump"
	
func _physics_process():
	._physics_process()

	if not player.is_jumping:
		player.is_jumping = true
		player.velocity.y = player.jump_strength
		
	elif player.velocity.y < 0:
		locomotion.set_fall_state()
	
	if locomotion.previous_state is Idle:
		if is_forward():
			move_forward(player.walking_speed)
		elif is_back():
			move_back(player.walking_speed)

func exit():
	.exit()
