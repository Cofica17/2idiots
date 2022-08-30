extends KinematicBody

onready var animation_tree := $AnimationTree

var state_machine

func _ready():
	state_machine = animation_tree.get("parameters/playback")
