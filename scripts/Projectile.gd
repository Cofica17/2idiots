extends KinematicBody

var type

func _ready():
	add_child(Nodes.get_bolt(type))
	add_child(Nodes.get_trail(type))
	pass

func get_type() -> String:
	return type

func set_type(_type) -> void:
	type = _type
