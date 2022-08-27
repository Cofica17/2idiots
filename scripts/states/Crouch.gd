extends State
class_name Crouch

func enter():
	.enter()
	#Play animation

func get_class() -> String: return "Crouch"

func _physics_process():
	._physics_process()
	
	if Input.is_action_just_released(CROUCH):
		locomotion.set_idle_state()
		
	if is_forward():
		move_forward(player.crouch_speed)
	elif is_back():
		move_back(player.crouch_speed)
	else:
		player.velocity = lerp(player.velocity, Vector3.ZERO, player.stopping_speed_ground)
	
	if Input.is_action_pressed(MOVE_LEFT):
		turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()

func exit():
	.exit()
