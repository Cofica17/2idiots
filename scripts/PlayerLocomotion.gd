class_name PlayerLocomotion

var player:KinematicBody
var state setget set_state

var idle = Idle.new()
var run = Run.new()
var walk = Walk.new()
var jump = Jump.new()
var fall = Fall.new()
var crouch = Crouch.new()
var slide = Slide.new()

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
	
func set_crouch_state():
	set_state(crouch)
	
func set_slide_state():
	set_state(slide)
