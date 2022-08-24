extends State
class_name Jump

func enter():
	.enter()
	play_animation("jump")

func _physics_process():
	._physics_process()
	if not player.is_jumping:
		player.is_jumping = true
		player.velocity.y = player.jump_strength * max((player.velocity.length() / player.running_speed), 1)
		print(player.jump_strength * max((player.velocity.length() / player.running_speed), 1))
	elif player.is_on_floor():
		player.is_jumping = false
		locomotion.set_idle_state()
	
	if Input.is_action_pressed(MOVE_LEFT):
			turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()
	
func exit():
	.exit()
