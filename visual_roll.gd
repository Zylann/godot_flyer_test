extends MeshInstance


func _ready():
	set_process(true)


func _process(delta):
	var cmd = get_parent().get_turn_cmd()
	cmd *= 0.3
	set_rotation(Vector3(PI+cmd.y, 0, PI-cmd.x))
