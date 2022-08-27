extends State
class_name Dash

var is_dashing = false

func enter():
	.enter()
	if not player.get_can_dash():
		locomotion.set_state(locomotion.previous_state)

func get_class() -> String: return "Dash"

func _physics_process():
	._physics_process()
	
	if not is_dashing:
		is_dashing = true
		player.change_stamina(-player.required_dash_stamina) 
		if is_forward():
			move_forward(player.dash_move_forward)
		if is_back():
			move_back(player.dash_move_forward)
		
	if is_dashing:
		player.velocity = lerp(player.velocity, Vector3.ZERO, player.dash_stopping_speed)
		if player.velocity.length() < player.dash_idle_treshold:
			is_dashing = false
			if is_forward() or is_back():
				locomotion.set_walk_state()
			else:
				locomotion.set_idle_state()

func exit():
	.exit()
