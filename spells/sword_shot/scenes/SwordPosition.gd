extends Position3D

var StingSword = load("res://spells/sword_shot/scenes/StingSword.tscn")
var sword

func shoot_sword(_speed):
	if not sword:
		return
	
	if sword.can_shoot:
		sword.shoot(_speed)
		sword = null

func spawn_sword(time=0.0):
	if sword:
		return
	
	sword = StingSword.instance()
	add_child(sword)
	
	if not time == 0.0:
		sword.animation_player.playback_speed = 1/time
		sword.spawn()

func destroy_sword(time):
	if not sword:
		return
	
	sword.animation_player.playback_speed = (1/time)
	sword.destroy()
	sword = null
