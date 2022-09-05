extends Spatial

onready var projectile = load("res://scenes/Projectile.tscn")

export(NodePath) var PlayerPath  = ""

export var projectile_number = 6
export var radius = 13
export var rotation_angle_y = 0.02
export var rotation_angle_x = 0.0025

var projectile_distance = (2 * radius * PI) / projectile_number
var projectile_angle_distance = 2 * PI / projectile_number
var player

func _ready():
	player = get_node(PlayerPath)
	player.connect("attacked", self, "_on_player_attacked")
	render_projectiles()

func _physics_process(delta):
	rotate_projectiles()

func render_projectiles() -> void:
	for i in range(0, projectile_number):
		var p = projectile.instance()
		if i%2 == 0:
			p.set_type("Poison")
		else:
			p.set_type("Poison")
		var x = sqrt(radius) * cos(projectile_angle_distance * i)
		var y = sqrt(radius) * sin(projectile_angle_distance * i) 
		p.translation = Vector3.ZERO + Vector3(x,y,0)
		add_child(p)

func rotate_projectiles() -> void:
	rotate(Vector3(1,0,0), rotation_angle_x)
	rotate(Vector3(0,1,0), rotation_angle_y)

func _on_player_attacked():
#	if get_child_count() > 0:
#		var child = get_children()[0]
#		print(child.global_transform.origin)
#		get_children()[0].queue_free()
	pass
