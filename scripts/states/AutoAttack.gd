extends KinematicBody

export var gravity = Vector3(0, -5, 0)
export var speed = 20

var velocity = Vector3.ZERO

func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
	apply_gravity(delta)
	move_and_slide(velocity, Vector3.UP)
	destroy()

func apply_gravity(delta) -> void:
	velocity += gravity * delta

func set_bullet_direction(direction) -> void:
	velocity = direction * speed

func destroy() -> void:
	if velocity.length() < 1:
		print("Destroyed")
		queue_free()
