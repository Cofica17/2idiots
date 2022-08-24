class_name PlayerLocomotion

var player:KinematicBody
var state setget set_state

var idle = Idle.new()
var run = Run.new()
var walk = Walk.new()
var jump = Jump.new()
var fall = Fall.new()

func _init(_player):
	player = _player

func set_state(v):
	if state:
		state.exit()
	
	state = v
	state.init(player, self)
	state.enter()

func _physics_process():
	state._physics_process()

func transition_to_state(_state):
	match _state:
		LocomotionStates.STATES.IDLE:
			set_state(idle)
		LocomotionStates.STATES.WALK:
			set_state(walk)
		LocomotionStates.STATES.JUMP:
			set_state(jump)
		LocomotionStates.STATES.RUN:
			set_state(run)
		LocomotionStates.STATES.FALL:
			set_state(fall)

func set_idle_state():
	set_state(idle)

func set_walk_state():
	set_state(walk)

func set_run_state():
	set_state(run)
	
func set_jump_state():
	set_state(jump)
	
func set_fall_state():
	set_state(fall)
