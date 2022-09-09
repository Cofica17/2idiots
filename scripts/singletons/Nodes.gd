extends Node

onready var player = get_node("/root/World/Players/Player")
onready var crosshair = get_node("/root/World/UI/CrosshairContainer")
onready var frostbolt_bolt = load("res://scenes/ProjectileParticles/Frost_Bolt.tscn")
onready var frostbolt_trail = load("res://scenes/ProjectileParticles/Frost_Trail.tscn")
onready var firebolt_bolt = load("res://scenes/ProjectileParticles/Fire_Bolt.tscn")
onready var firebolt_trail = load("res://scenes/ProjectileParticles/Fire_Trail.tscn")
onready var lightning_bolt = load("res://scenes/ProjectileParticles/Lightning_Bolt.tscn")
onready var lightning_trail = load("res://scenes/ProjectileParticles/Lightning_Trail.tscn")
onready var poison_bolt = load("res://scenes/ProjectileParticles/Poison_Bolt.tscn")
onready var poison_trail = load("res://scenes/ProjectileParticles/Poison_Trail.tscn")
onready var wind_bolt = load("res://scenes/ProjectileParticles/Wind_Bolt.tscn")
onready var wind_trail = load("res://scenes/ProjectileParticles/Wind_Trail.tscn")

func _ready():
	pass
	
func get_player() -> KinematicBody:
	return player

func get_crosshair() -> Control:
	return crosshair

func get_bolt(name) -> Particles:
	match name:
		"Frost":
			return frostbolt_bolt.instance()
		"Fire":
			return firebolt_bolt.instance()
		"Lightning":
			return lightning_bolt.instance()
		"Poison":
			return poison_bolt.instance()
		"Wind":
			return wind_bolt.instance()
		_:
			return null

func get_trail(name) -> Particles:
	match name:
		"Frost":
			return frostbolt_trail.instance()
		"Fire":
			return firebolt_trail.instance()
		"Lightning":
			return lightning_trail.instance()
		"Poison":
			return poison_trail.instance()
		"Wind":
			return wind_trail.instance()
		_:
			return null
