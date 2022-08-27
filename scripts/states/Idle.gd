extends State
class_name Idle

func enter():
	.enter()
	play_animation("idle")

func get_class() -> String: return "Idle"

func _physics_process():
	._physics_process()
	
	if is_auto_attack():
		locomotion.set_attack_state()
	if is_forward() or is_back():
		locomotion.set_walk_state()
	if is_jump():
		locomotion.set_jump_state()
	if is_crouch():
		locomotion.set_crouch_state()
	
	player.velocity = lerp(player.velocity, Vector3.ZERO, player.stopping_speed_ground)

func exit():
	.exit()
