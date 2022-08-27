extends KinematicBody

export var gravity = Vector3(0, -2, 0)
export var velocity = Vector3.ZERO
export var speed = 10
var player_camera = null
var bullet_direction = null
var player = null

func _ready():
	player = get_parent()
	if not player_camera:
		player_camera = player.camera_controller
	if not bullet_direction:
		bullet_direction = player_camera.get_bullet_direction() * speed
	
func _physics_process(delta):
	apply_gravity(delta)
	velocity = move_and_slide(bullet_direction, Vector3.UP)
	destroy()
	
func apply_gravity(delta) -> void:
	velocity += gravity * delta

func destroy() -> void:
	if velocity.length() < 1:
		print("Destroyed")
		queue_free()
