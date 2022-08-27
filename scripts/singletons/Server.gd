extends Node

var network = NetworkedMultiplayerENet.new()
var port = 7769
var ip = "127.0.0.1"

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
