extends KinematicBody

export var gravity = Vector3(0, -2, 0)
export var velocity = Vector3.ZERO

func _ready():
	velocity.z += 30
	pass

func _physics_process(delta):
	apply_gravity(delta)
	velocity = lerp(velocity, Vector3.ZERO, 0.01)
	velocity = move_and_slide(velocity, Vector3.UP)
	if velocity.length() < 1:
		queue_free()
	
func apply_gravity(delta) -> void:
	velocity += gravity * delta
