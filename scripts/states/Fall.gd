extends State
class_name Fall
var sphere = load("res://scenes/Spell.tscn") 
var sphere_node
func enter():
	.enter()
	#Play animation

func get_class() -> String: return "Fall"

func _physics_process():
	._physics_process()
	
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
			sphere_node = sphere.instance()
			player.get_tree().root.add_child(sphere_node)
			sphere_node.global_transform = player.global_transform
			player.is_double_jumping = true
			player.is_jumping = false
			locomotion.set_jump_state()
			
	if Input.is_action_pressed(MOVE_LEFT):
		turn_left()
	if Input.is_action_pressed(MOVE_RIGHT):
		turn_right()
	
func exit():
	.exit()
