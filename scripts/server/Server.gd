extends Node

var network = NetworkedMultiplayerENet.new()
var port = 7769
#var ip = "127.0.0.1"
var ip = "194.36.45.181"
var latency = 0
var latency_array = []
var client_clock = 0.0
var delta_latency = 0
var decimal_collector:float = 0.0

func _ready():
	connect_to_server()

func connect_to_server():
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "_on_connection_succeeded")

func _on_connection_succeeded():
	print("Succesfully Connected")
	rpc_id(1, "send_server_time", OS.get_system_time_msecs())
	var timer = Timer.new()
	timer.wait_time = 0.5
	timer.autostart = true
	timer.connect("timeout", self ,"determine_latency")
	add_child(timer)
#	timer.start()

func _on_connection_failed():
	print("Failed to Connect")

func _physics_process(delta):
	client_clock += int(delta*1000) + delta_latency
	delta_latency = 0
	decimal_collector += (delta*1000) - int(delta*1000)
	if decimal_collector >= 1.00:
		client_clock += 1
		decimal_collector -= 1.00


##############
### REMOTE ###
##############

remote func receive_server_time(server_time, client_time):
	latency = (OS.get_system_time_msecs() - client_time) / 2
	client_clock = server_time + latency

remote func return_latency(client_time):
	latency_array.append((OS.get_system_time_msecs() - client_time)/2)
	if latency_array.size() == 9:
		var total_latency = 0
		latency_array.sort()
		var mid_point = latency_array[4]
		for i in range(latency_array.size()-1, -1, -1):
			if latency_array[i] > (2*mid_point) and latency_array[i] > 20:
				latency_array.remove(i)
			else:
				total_latency += latency_array[i]
		delta_latency = (total_latency / latency_array.size()) - latency
		latency = total_latency / latency_array.size()
		latency_array.clear()

remote func receive_world_state(world_state:Dictionary):
	get_node("../World").receive_world_state(world_state)

remote func receive_player_animation(data):
	get_node("../World").receive_player_animation(data)

########################
### FOR SENDING INFO ###
########################

func determine_latency():
	rpc_id(1, "determine_latency", OS.get_system_time_msecs())

func send_player_transform(transform):
	var d = {
		"T" : client_clock,
		"P" : transform
	}
	rpc_unreliable_id(1, "receive_player_transform", d)

func send_player_animation(anim):
	rpc_id(1, "receive_player_animation", anim)
