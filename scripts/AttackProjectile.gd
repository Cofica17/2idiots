extends KinematicBody

export var gravity = Vector3(0, -4, 0)
export var velocity = Vector3.ZERO
export var speed = 250
export var destroy_distance = 100
var bullet_direction = Vector3.ZERO

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
	if translation.distance_to(get_parent().translation) > destroy_distance:
		print("Destroyed")
		queue_free()

