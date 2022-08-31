extends State
class_name Run

func enter():
	.enter()
	play_animation(LocomotionStates.ANIMATIONS.RUN)
	if not player.get_can_sprint():
		locomotion.set_state(locomotion.previous_state)

func get_class() -> String: return "Run"

func _physics_process():
	._physics_process()

	if Input.is_action_just_pressed(DASH):
		locomotion.set_dash_state()
		return
	if is_jump():
		locomotion.set_jump_state()
		return
	if is_crouch():
		locomotion.set_slide_state()
		return
	if not is_sprint():
		locomotion.set_walk_state()
		return
	
	
	if is_direction():
		if player.get_can_sprint():
			player.change_stamina(-player.stamina_loss)
			move(player.running_speed)
		else:
			locomotion.set_walk_state()
			return
	else:
		locomotion.set_idle_state()
		return

func exit():
	.exit()
