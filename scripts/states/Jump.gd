extends State
class_name Jump

func init(_player, _locomotion):
	.init(_player, _locomotion)
	print("Jump")

func _physics_process():
	if player.is_on_floor():
		if Input.is_action_pressed(SPRINT) and Input.is_action_pressed(MOVE_FORWARD):
			locomotion.set_state(Run)
		elif (Input.is_action_pressed(MOVE_FORWARD) or Input.is_action_pressed(MOVE_BACK)) and !Input.is_action_pressed(SPRINT):
			locomotion.set_state(Walk)
		else:
			locomotion.set_state(Idle)
	else:
		player.velocity.y = player.jump_strength
		
func exit():
	pass
