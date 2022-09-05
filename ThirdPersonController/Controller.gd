extends Spatial

onready var inner_gimbal = $InnerGimbal
onready var camera = $InnerGimbal/Camera
onready var crosshair
onready var raycast = $InnerGimbal/Camera/RayCast

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
var fov_scope_in_sec = 0.75
var fov_scope_out_sec = 0.25
var target_field_of_view = field_of_view
var tween:Tween = Tween.new()

func _ready():
	rng.randomize()
	crosshair = Nodes.get_crosshair()
	player = get_node(PlayerPath)
	player.connect("scope_in", self, "_on_player_scope_in")
	player.connect("scope_out", self, "_on_player_scope_out")
	add_child(tween)
	raycast.add_exception(player)

func _unhandled_input(event):
	if event is InputEventMouseMotion :
		rot = event.relative

func _physics_process(delta):
	player.rotate_y(deg2rad(-rot.x)*delta*mouse_sensitivity)
	inner_gimbal.rotate_x(deg2rad(rot.y)*delta*mouse_sensitivity)
	inner_gimbal.rotation_degrees.x = clamp(inner_gimbal.rotation_degrees.x, -rot_x_limit, rot_x_limit)
	rot = Vector2()

func _on_player_scope_in(time):
	change_camera_fov(scope_field_of_view, time)

func _on_player_scope_out(time):
	change_camera_fov(field_of_view, time)

func change_camera_fov(new_fov, sec):
	tween.remove_all()
	tween.interpolate_property(camera, "fov", camera.fov, new_fov,
	sec, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func calculate_ray_target() -> Vector2:
	var R = crosshair.current_recoil * recoil_to_spread_ratio
	var theta = rng.randf_range(0, 2 * PI)
	var r = rng.randf_range(0, R)
	var x = sqrt(r * R) * cos(theta)
	var y = sqrt(r * R) * sin(theta)
	var ray_target = get_viewport().size/2
	ray_target.x += x
	ray_target.y += y
	return ray_target
	
func get_attack_direction() -> Vector3:
	return camera.project_ray_normal(calculate_ray_target())
