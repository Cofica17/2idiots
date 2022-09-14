extends Spatial

#[PastState, MostRecetPastState, NearestFutureState, AnyOtherFutureStatesRecevied]
var world_state_buffer := []
var last_world_state_time:float = 0.0

const interpolation_offset = 10
const PLAYER_CLONE = preload("res://scenes/PlayerClone.tscn")

onready var players = $Players

func get_player_clone(player_id):
	var clone
	
	for c in players.get_children():
		if c.user_id == player_id:
			clone = c
	
	return clone

func _physics_process(delta):
	if world_state_buffer.size() <= 1:
		return
	
	var render_time = Server.client_clock - interpolation_offset 
	#var render_time = OS.get_system_time_msecs() - interpolation_offset 
	while world_state_buffer.size() > 2 and render_time > world_state_buffer[1].T:
		world_state_buffer.remove(0)
	
	#if world_state_buffer.size() > 2:
	var interpolation_factor = float(render_time - world_state_buffer[0].T) / float(world_state_buffer[1].T - world_state_buffer[0].T)
	#print(float(render_time - world_state_buffer[0].T))
	#print(float(world_state_buffer[1].T - world_state_buffer[0].T))
	#print(interpolation_factor)
	#print("****")
	for player_id in world_state_buffer[1].keys():
		if str(player_id) == "T" or player_id == get_tree().get_network_unique_id():
			continue
		if not world_state_buffer[0].has(player_id):
			continue
		var player_clone = get_player_clone(player_id)
		if player_clone:
			var new_transform = world_state_buffer[0][player_id].P.interpolate_with(world_state_buffer[1][player_id].P, interpolation_factor)
			var new_aim_point = world_state_buffer[0][player_id].AP.linear_interpolate(world_state_buffer[1][player_id].AP, interpolation_factor)
			player_clone.global_transform = new_transform
			player_clone.aim_point = new_aim_point 
		else:
			var clone = PLAYER_CLONE.instance()
			clone.user_id = player_id
			players.add_child(clone)
			Nodes.player_clone = clone
#	elif render_time > world_state_buffer[1].T:
#		var extrapolation_factor = float(render_time - world_state_buffer[0].T) / float(world_state_buffer[1].T)
#		for player_id in world_state_buffer[1]:
#			if str(player_id) == "T" or player_id == get_tree().get_network_unique_id():
#				continue
#			if not world_state_buffer[0].has(player_id):
#				continue
#			var player_clone = get_player_clone(player_id)
#			if player_clone:
#				var position_delta = (world_state_buffer[1][player_id].P.origin - world_state_buffer[0][player_id].P.origin)
#				#var rotation_delta = (world_state_buffer[1][player_id].P.basis - world_state_buffer[0][player_id].P.basis)
#				var aim_point_delta = (world_state_buffer[1][player_id].AP - world_state_buffer[0][player_id].AP)
#				var new_position = world_state_buffer[1][player_id].P.origin + (position_delta * extrapolation_factor)
#				#var new_rotation = world_state_buffer[1][player_id].P.basis + (position_delta * extrapolation_factor)
#				var new_aim_point = world_state_buffer[1][player_id].AP + (aim_point_delta * extrapolation_factor)
#				player_clone.global_transform.origin = new_position
#				#player_clone.global_transform.basis = new_rotation
#				player_clone.aim_point = new_aim_point 

func receive_world_state(world_state:Dictionary):
	if world_state["T"] < last_world_state_time:
		return
	
	last_world_state_time = world_state["T"]
	world_state_buffer.append(world_state)

func receive_player_animation(data):
	if data["I"] == Server.network.get_unique_id():
		return
	
	var p = get_player_clone(data.I)
	if p:
		#print(data["A"])
		#p.state_machine.travel(data["A"])
		p.animation_tree["parameters/state/current"] = data["A"]

func receive_player_basic_attack(data):
	if data["I"] == Server.network.get_unique_id():
		return
	
	var p = get_player_clone(data.I)
	if p:
		match data.A:
			BasicAttack.ATTACK.PRIMARY:
				p.basic_attack.primary_attack(data.P)
			BasicAttack.ATTACK.SECONDARY:
				p.basic_attack.secondary_attack(data.P)

func receive_player_scope_in(id):
	if id == Server.network.get_unique_id():
		return
	
	var p = get_player_clone(id)
	p.scope_in()

func receive_player_scope_out(id):
	if id == Server.network.get_unique_id():
		return
	
	var p = get_player_clone(id)
	p.scope_out()

func receive_player_health(data):
	if data.id == Server.network.get_unique_id():
		return
	
	var clone = get_player_clone(data.id)
	if clone:
		clone.set_health(data.health)
