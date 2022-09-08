extends Control

onready var ping = $PingControl/Ping

func set_ping(p):
	ping.text = "ping: " + str(p)
