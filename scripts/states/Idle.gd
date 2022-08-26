extends State
class_name Idle

func enter():
	.enter()
	#Play animation

func get_class() -> String: return "Idle"

func _physics_process():
	._physics_process()
	
	if is_attacking():
		locomotion.set_attack_state()
	if is_forward() or is_back():
		locomotion.set_walk_state()
	if is_jump():
		locomotion.set_jump_state()
	if is_crouch():
		locomotion.set_crouch_state()
	
	player.velocity = lerp(player.velocity, Vector3.ZERO, player.stopping_speed_ground)
	
	if Input.is_action_pressed(MOVE_LEFT):
		turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()

func exit():
	.exit()
