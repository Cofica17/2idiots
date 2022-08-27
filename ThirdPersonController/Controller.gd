extends Spatial

export(NodePath) var PlayerPath  = "" #You must specify this in the inspector!
export(float) var mouse_sensitivity = 4.0
export var rot_x_limit = 25
onready var inner_gimbal = $InnerGimbal
onready var camera = $InnerGimbal/Camera

var player:Player
var rot := Vector2.ZERO

func _ready():
	player = get_node(PlayerPath)

func _unhandled_input(event):
	if event is InputEventMouseMotion :
		rot = event.relative

func get_bullet_direction() -> Vector3:
	return camera.project_ray_normal(get_viewport().size/2)

func _physics_process(delta):
	player.rotate_y(deg2rad(-rot.x)*delta*mouse_sensitivity)
	inner_gimbal.rotate_x(deg2rad(rot.y)*delta*mouse_sensitivity)
	inner_gimbal.rotation_degrees.x = clamp(inner_gimbal.rotation_degrees.x, -rot_x_limit, rot_x_limit)
	rot = Vector2()
