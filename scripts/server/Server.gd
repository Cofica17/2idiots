extends Node

var network = NetworkedMultiplayerENet.new()
var port = 7769
var ip = "127.0.0.1"
#var ip = "194.36.45.181"

func _ready():
	connect_to_server()

func connect_to_server():
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "_on_connection_succeeded")

func _on_connection_succeeded():
	print("Succesfully Connected")

func _on_connection_failed():
	print("Failed to Connect")


##############
### REMOTE ###
##############

remote func receive_world_state(world_state:Dictionary):
	get_node("../World").receive_world_state(world_state)

remote func receive_player_animation(data):
	get_node("../World").receive_player_animation(data)


########################
### FOR SENDING INFO ###
########################

func send_player_transform(transform):
	var d = {
		"T" : OS.get_system_time_msecs(),
		"P" : transform
	}
	rpc_unreliable_id(1, "receive_player_transform", d)

func send_player_animation(anim):
	rpc_id(1, "receive_player_animation", anim)
