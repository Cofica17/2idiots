extends State
class_name Jump

func init(_player, _locomotion):
	.init(_player, _locomotion)
	print("Jump")

func _physics_process():
	player.is_jumping = true
	player.velocity.y = player.jump_strength * max((player.velocity.length() / player.walking_speed), 1)
	print(player.jump_strength * max((player.velocity.length() / player.walking_speed), 1))
	locomotion.set_idle_state()
	
func exit():
	pass
