extends State
class_name AutoAttack

var projectile = load("res://scenes/Spell.tscn") 
var projectile_node

func enter():
	.enter()
	#Play animation

func get_class() -> String: return "AutoAttack"

func _physics_process():
	._physics_process()
	
	projectile_node = projectile.instance()
	projectile_node.translation = player.translation + Vector3(0,1.5,0.3)
	player.get_tree().root.add_child(projectile_node)
	
	if is_forward() or is_back():
		locomotion.set_walk_state()
	else:
		locomotion.set_idle_state()


func exit():
	.exit()
