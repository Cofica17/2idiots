extends State
class_name Jump

func enter():
	.enter()
	#Play animation
	print("Jump")
	
func _physics_process():
	._physics_process()

	if not player.is_jumping:
		player.is_jumping = true
		player.velocity.y = player.jump_strength
		
	elif player.velocity.y < 0:
		locomotion.set_fall_state()
		
	if Input.is_action_pressed(MOVE_LEFT):
		turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()
	
func exit():
	.exit()
