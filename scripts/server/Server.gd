extends Node

var network = NetworkedMultiplayerENet.new()
var port = 1909
#var ip = "127.0.0.1"
var ip = "194.36.45.181"
var connected = false
var latency:float = 0.0
var latency_array = [] 
var client_clock:float = 0.0
var delta_latency:float = 0.0
var decimal_collector:float = 0.0
var world_str = "../World"

func _ready():
	connect_to_server()

func connect_to_server():
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "_on_connection_succeeded")

func _on_connection_succeeded():
	connected = true
	print("Succesfully Connected")
	rpc_id(1, "send_server_time", OS.get_system_time_msecs())
	var timer = Timer.new()
	timer.wait_time = 0.5
	timer.autostart = true
	timer.connect("timeout", self ,"determine_latency")
	add_child(timer)

func _on_connection_failed():
	print("Failed to Connect")

func _physics_process(delta):
	client_clock += int(delta*1000) + delta_latency
	delta_latency = 0
	decimal_collector += (delta*1000) - int(delta*1000)
	if decimal_collector >= 1.00:
		client_clock += 1
		decimal_collector -= 1.00
	#print(client_clock)


##############
### REMOTE ###
##############

remote func receive_server_time(server_time, client_time):
	latency = (OS.get_system_time_msecs() - client_time) / 2
	client_clock = server_time + latency
	Nodes.UI.set_ping(latency*2)

remote func return_latency(client_time):
	latency_array.append((OS.get_system_time_msecs() - client_time)/2)
	if latency_array.size() == 9:
		var total_latency = 0.0
		latency_array.sort()
		var mid_point = latency_array[4]
		for i in range(latency_array.size()-1, -1, -1):
			if latency_array[i] > (2*mid_point):
				latency_array.remove(i)
			else:
				total_latency += latency_array[i]
		delta_latency = (total_latency / latency_array.size()) - latency
		latency = total_latency / latency_array.size()
		latency_array.clear()
		Nodes.UI.set_ping(latency*2)

remote func receive_world_state(world_state:Dictionary):
	get_node(world_str).receive_world_state(world_state)

remote func receive_player_animation(data):
	get_node(world_str).receive_player_animation(data)

remote func receive_player_basic_attack(data):
	get_node(world_str).receive_player_basic_attack(data)

remote func receive_player_scope_in(id):
	get_node(world_str).receive_player_scope_in(id)

remote func receive_player_scope_out(id):
	get_node(world_str).receive_player_scope_out(id)

#TODO: REFACTOR TO BE SERVER-SIDE
remote func receive_damage(data):
	if data.I == get_tree().get_network_unique_id():
		return
	
	Nodes.player.receive_damage(data.D)

remote func receive_player_health(data):
	get_node(world_str).receive_player_health(data)

########################
### FOR SENDING INFO ###
########################

func determine_latency():
	if not connected:
		return
	
	rpc_id(1, "determine_latency", OS.get_system_time_msecs())

func send_player_info(transform, aim_point):
	if not connected:
		return
	
	var d = {
		"T" : OS.get_system_time_msecs(),
		"P" : transform,
		"AP" : aim_point
	}
	rpc_unreliable_id(1, "receive_player_info", d)

func send_player_animation(anim):
	if not connected:
		return
	
	rpc_id(1, "receive_player_animation", anim)

func send_player_basic_attack(attack, global_pos):
	if not connected:
		return
	
	var data = {
		"T" : client_clock,
		"A" : attack,
		"P" : global_pos
	}
	
	rpc_id(1, "receive_player_basic_attack", data)

func send_player_scope_in():
	rpc_id(1, "receive_player_scope_in")

func send_player_scope_out():
	rpc_id(1, "receive_player_scope_out")

#TODO: REFACTOR TO BE SERVER-SIDE
func send_damage(dmg):
	rpc_id(1, "receive_player_damage", dmg)

func send_player_health(health):
	rpc_id(1, "receive_player_health", health)
