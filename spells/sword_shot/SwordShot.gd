extends BasicAttack

var reload_time = 1.15
var rng = RandomNumberGenerator.new()
var can_shoot_primary = true

func primary_attack():
	if not can_shoot_primary:
		return
	
	rng.randomize()
	var num = rng.randi_range(0, get_child_count()-1)
	var c = get_child(num)
	c.spawn_sword()
	c.look_at(Nodes.player.get_aim_point(), Vector3.UP)
	c.sword.can_shoot = true
	c.shoot_sword(speed)

func secondary_attack():
	for c in get_children():
		c.shoot_sword(speed)
	Nodes.player.emit_signal("scope_out", Nodes.player.fov_scope_out_sec)
	can_shoot_primary = true

func _on_scope_in(time):
	._on_scope_in(time)
	
	can_shoot_primary = false
	
	for c in get_children():
		c.spawn_sword(time)

func _on_scope_out(time):
	._on_scope_out(time)
	
	can_shoot_primary = true
	
	for c in get_children():
		c.destroy_sword(time)
