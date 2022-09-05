extends Spatial

onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var area = $Area

var shoot = false
var look = true
var speed
var direction
var can_shoot = false

func _ready():
	animation_player.connect("animation_finished", self, "_on_anim_finished")
	area.connect("body_entered", self, "_on_body_entered")

func _physics_process(delta):
	if shoot:
		global_transform.origin += direction * speed * delta
	elif look:
		look_at(Nodes.player.get_aim_point(), Vector3.UP)

func spawn():
	animation_player.play("show_sword")

func shoot(_speed):
	shoot = true
	look = false
	speed = _speed
	direction = global_transform.origin.direction_to(Nodes.player.get_aim_point())
	set_as_toplevel(true)
	$Area/CollisionShape.disabled = false
	$Trail.emitting = true

func destroy():
	animation_player.play("destroy")

func _on_anim_finished(anim):
	if anim == "destroy":
		queue_free()
	elif anim == "show_sword":
		can_shoot = true

func _on_body_entered(body):
	shoot = false
	$Trail.emitting = false
	#$Destroy.emitting = true
	destroy()
