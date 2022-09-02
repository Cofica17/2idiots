extends Control

onready var crosshair = $Crosshair
onready var player = Nodes.get_player()
onready var min_recoil = player.player_locomotion.state.min_recoil
onready var max_recoil = player.player_locomotion.state.max_recoil

export var crosshair_reduction_time = 0.3
export var crosshair_offset = 0.015

var current_recoil = 1
var time = 0
var recoil_values_dict = {
	0:0.04,
	1:0.05,
	2:0.06,
	3:0.07,
	4:0.08,
	5:0.09,
	6:0.10,
	7:0.11,
	8:0.12,
	9:0.13,
}

func _ready():
	player.connect("attacked", self, "_on_player_attacked")

func _physics_process(delta):
	min_recoil = player.player_locomotion.state.min_recoil
	max_recoil = player.player_locomotion.state.max_recoil
	adjust_recoil(delta)
	adjust_crosshair()

func adjust_crosshair() -> void:
	var scale = recoil_values_dict.get(current_recoil)
	var scale_vector = Vector2(scale, scale)
	var viewport_size = get_viewport_rect().size
	crosshair.scale = scale_vector
	crosshair.set_global_position(Vector2(viewport_size.x / 2, viewport_size.y / 2 + crosshair_offset * viewport_size.y))
	
func adjust_recoil(delta) -> void:
	time += delta
	if time >= crosshair_reduction_time:
		if current_recoil > min_recoil:
			current_recoil -= 1
		time = 0
	if current_recoil < min_recoil:
		current_recoil = min_recoil
		
func _on_player_attacked():
	if current_recoil < max_recoil:
		current_recoil += 1
