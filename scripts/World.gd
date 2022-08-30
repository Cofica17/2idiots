extends Spatial

#[MostRecetPasState, NearestFutureState, AnyOtherFutureStatesRecevied]
var world_state_buffer := []
var last_world_state_time:float = 0.0

const interpolation_offset = 100
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
	while world_state_buffer.size() > 2 and render_time > world_state_buffer[1].T:
		world_state_buffer.remove(0)
	var interpolation_factor = float(render_time - world_state_buffer[0].T) / float(world_state_buffer[1].T - world_state_buffer[0].T) 
	
	for player_id in world_state_buffer[1]:
		if str(player_id) == "T" or player_id == get_tree().get_network_unique_id():
			continue
		if not world_state_buffer[0].has(player_id):
			continue
		var player_clone = get_player_clone(player_id)
		if player_clone:
			var new_transform = world_state_buffer[0][player_id].P.interpolate_with(world_state_buffer[1][player_id].P, interpolation_factor)
			player_clone.global_transform = new_transform
		else:
			var clone = PLAYER_CLONE.instance()
			clone.user_id = player_id
			players.add_child(clone)

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
		p.state_machine.travel(data["A"])
