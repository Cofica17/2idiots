extends State
class_name Attack

var projectile = load("res://scenes/AutoAttack.tscn")
var projectile_instance

func enter():
	.enter()
	#play_animation("slow_run")

func get_class() -> String: return "Attack"

func _physics_process():
	._physics_process()
	
	projectile_instance = projectile.instance()
	projectile_instance.translation = Vector3.ZERO + Vector3(0.5,0.5,0.5)
	player.add_child(projectile_instance)
	
	if is_jump():
		locomotion.set_jump_state()
	if is_crouch():
		locomotion.set_crouch_state()
	if is_dash() and player.get_can_dash():
		locomotion.set_dash_state()
	if is_sprint() and not is_back():
		locomotion.set_run_state()
	
	if is_forward():
		move_forward(player.walking_speed)
	elif is_back():
		move_back(player.walking_speed)
	else:
		locomotion.set_idle_state()

func exit():
	.exit()
