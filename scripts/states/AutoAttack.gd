extends KinematicBody

export var gravity = Vector3(0, -10, 0)
export var velocity = Vector3.ZERO
export var speed = 10
var bullet_direction = Vector3.ZERO

func _physics_process(delta):
	apply_gravity(delta)
	velocity = move_and_slide(bullet_direction, Vector3.UP)
	destroy()
	
func apply_gravity(delta) -> void:
	velocity += gravity * delta

func set_bullet_direction(direction) -> void:
	bullet_direction = direction * speed
	
func destroy() -> void:
	if velocity.length() < 1:
		print("Destroyed")
		queue_free()
