extends Camera

const Noise = preload("simplex.gd")

export var shake_amount = 0.1


func _process(delta):
	# Camera shake
	var k1 = 0.005
	var k2 = 0.01
	var time = OS.get_ticks_msec()
	var shake_x = shake_amount * (Noise.simplex2(time*k1, 0) + 0.3*Noise.simplex2(time*k2, 2))
	var shake_y = shake_amount * (Noise.simplex2(time*k1, 1) + 0.3*Noise.simplex2(time*k2, 3))
	
	# Speed offset
	var speed_offset = get_parent().get_turn_cmd()
	
	set_h_offset(shake_x - 2.0*speed_offset.x)
	set_v_offset(shake_y + speed_offset.y)

