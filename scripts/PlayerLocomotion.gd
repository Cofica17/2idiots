class_name PlayerLocomotion

var player:KinematicBody
var state setget set_state
var previous_state = null

var idle = Idle.new()
var run = Run.new()
var walk = Walk.new()
var jump = Jump.new()
var fall = Fall.new()
var crouch = Crouch.new()
var slide = Slide.new()
var dash = Dash.new()

var cnt = 0

func _init(_player):
	player = _player

func set_state(v):
	if state:
		state.exit()
	
	previous_state = state
	state = v
	state.init(player, self)
	if not null == previous_state:
		print(state.get_class(), "|", previous_state.get_class(), "|", cnt)
		cnt += 1
	state.enter()

func _physics_process():
	state._physics_process()

func set_dash_state():
	set_state(dash)
	
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
