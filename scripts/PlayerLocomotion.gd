class_name PlayerLocomotion

var player:KinematicBody
var state setget set_state

var idle = Idle.new()
var run = Run.new()
var walk = Walk.new()

func _init(_player):
	player = _player
	set_state(idle)

func set_state(v):
	if state:
		state.exit()
	
	state = v
	state.init(player, self)

func _physics_process():
	state._physics_process()

func set_idle_state():
	set_state(idle)

func set_walk_state():
	set_state(walk)

func set_run_state():
	set_state(run)
