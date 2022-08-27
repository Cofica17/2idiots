extends Sprite
#This script will have purpose of changing crosshairs depending on user attacks

#Adding this to put corrshair a bit lower on the screen, to give more realistic aiming feel
var crosshair_offset = 0.01

func _ready():
	var viewport_size = get_viewport_rect().size
	global_position = Vector2(viewport_size.x / 2, viewport_size.y / 2 + crosshair_offset * viewport_size.y)
