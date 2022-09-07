extends Spatial
class_name BasicAttack

enum ATTACK {
	PRIMARY,
	SECONDARY
}

var speed := 80
var damage := 10

func primary_attack(global_pos):
	pass

func secondary_attack(global_pos):
	pass

func _on_scope_in(time):
	pass

func _on_scope_out(time):
	pass

func is_on_client() -> bool:
	return get_parent() == Nodes.player
