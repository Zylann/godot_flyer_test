extends MeshInstance


func _process(delta):
	# Rotate the wasp as if it took turns like a plane
	var cmd = get_parent().get_turn_cmd()
	cmd *= 0.3
	set_rotation(Vector3(PI+cmd.y, 0, PI-cmd.x))
