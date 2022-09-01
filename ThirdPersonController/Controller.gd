extends Spatial

onready var inner_gimbal = $InnerGimbal
onready var camera = $InnerGimbal/Camera
onready var ui

export(NodePath) var PlayerPath  = "" #You must specify this in the inspector!
export(float) var mouse_sensitivity = 5.0
export var rot_x_limit = 25
#This gives each point of recoil, #n points in spread circle radius
export var recoil_to_spread_ratio = 3

var rng = RandomNumberGenerator.new()
var player:Player
var rot := Vector2.ZERO
var field_of_view = 70
var scope_field_of_view = 50
var fov_change = 0.5
var target_field_of_view = field_of_view

func _ready():
	rng.randomize()
	ui = Nodes.get_ui()
	player = get_node(PlayerPath)
	connect_signals()

func _unhandled_input(event):
	if event is InputEventMouseMotion :
		rot = event.relative

func get_bullet_direction() -> Vector3:
	return camera.project_ray_normal(calculate_ray_target())

func _physics_process(delta):
	if camera.fov >target_field_of_view:
		camera.set_perspective(camera.fov - fov_change,0.05,100)
	elif camera.fov < target_field_of_view:
		camera.set_perspective(camera.fov + fov_change,0.05,100)

	player.rotate_y(deg2rad(-rot.x)*delta*mouse_sensitivity)
	inner_gimbal.rotate_x(deg2rad(rot.y)*delta*mouse_sensitivity)
	inner_gimbal.rotation_degrees.x = clamp(inner_gimbal.rotation_degrees.x, -rot_x_limit, rot_x_limit)
	rot = Vector2()

func calculate_ray_target() -> Vector2:
	var R = ui.current_recoil * recoil_to_spread_ratio
	var theta = rng.randf_range(0, 2 * PI)
	var r = rng.randf_range(0, R)
	var x = sqrt(r * R) * cos(theta)
	var y = sqrt(r * R) * sin(theta)
	var ray_target = get_viewport().size/2
	ray_target.x += x
	ray_target.y += y
	return ray_target
	
func _on_player_scope_in() -> void:
	target_field_of_view = scope_field_of_view
	print("Scope in")

func _on_player_scope_out() -> void:
	target_field_of_view = field_of_view
	print("Scope out")

func connect_signals() -> void:
	player.connect("scope_in", self, "_on_player_scope_in")
	player.connect("scope_out", self, "_on_player_scope_out")

