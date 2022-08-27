extends State
class_name Fall

func enter():
	.enter()
	#Play animation

func get_class() -> String: return "Fall"

func _physics_process():
	._physics_process()
	
	if is_auto_attack():
		player.player_attack.attack()
		
	if player.is_on_floor():
		player.is_jumping = false
		player.is_double_jumping = false
		if is_forward() or is_back():
			locomotion.set_walk_state()
		elif is_jump():
			locomotion.set_jump_state()
		else:
			locomotion.set_idle_state()
	else:
		if player.is_double_jumping == false and is_jump():
			player.is_double_jumping = true
			player.is_jumping = false
			locomotion.set_jump_state()

func exit():
	.exit()
