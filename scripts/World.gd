extends Spatial

var last_world_state_time:float = 0.0

remote func receive_world_state(world_state:Dictionary):
	if world_state["T"] < last_world_state_time:
		return
	
	last_world_state_time = world_state["T"]
	world_state.erase("T")
	world_state.erase(get_tree().get_network_unique_id())
	
	for key in world_state:
		var p = get_node("PlayerClone")
		if p :
			p.global_transform = p.global_transform.interpolate_with(world_state[key]["P"], 0.33)

remote func receive_player_animation(data):
	if data["I"] == Server.network.get_unique_id():
		return
	
	var p = get_node("PlayerClone")
	if p :
		p.state_machine.travel(data["A"])
