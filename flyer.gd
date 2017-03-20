
extends Spatial

const Util = preload("utility.gd")

const UP_VECTOR = Vector3(0,1,0)

export var speed = 20.0
export var turn_max_deg = Vector2(90, 90)
export var turn_damp = 0.1
export var stabilizer_speed = 1.0

var _turn_speed = 50.0
var _turn_cmd = Vector2(0,0) # In radians
var _roll = 0.0


func _ready():
	set_process(true)
	set_process_input(true)


func get_roll():
	return _roll


func get_turn_cmd():
	return _turn_cmd


func get_forward():
	return -transform.basis.z


func _process(delta):
	var pos = get_translation()
	
	#  #8071 would be nice :3
	var turn_max = Util.deg2radv(turn_max_deg)
	_turn_cmd = Util.clampv(_turn_cmd, -turn_max, turn_max)
	
	rotate(transform.basis.y, _turn_cmd.x * delta)
	rotate(transform.basis.x, _turn_cmd.y * delta)
	
	# When the plane is "horizontal enough", stabilize it.
	# It won't work if the plane is peaking up or down, due to gimbal lock.
	if abs(get_forward().y) < 0.5:
		
		# Get roll
		var current_basis = transform.basis
		var xy_plane = Plane(current_basis.z, 0)
		var projected_y = xy_plane.project(UP_VECTOR).normalized()
		#var angle = projected_y.angle_to(current_basis.y) # BROKEN
		var angle = Util.angle_to_fixed(projected_y, current_basis.y)
		angle *= sign(projected_y.dot(current_basis.x))
		_roll = angle
		
		# Get ideal no-roll orientation
		var noroll_basis = current_basis.rotated(current_basis.z, -_roll)
		
		# Tween to the ideal orientation
		var q = Quat(current_basis).slerp(Quat(noroll_basis), delta * stabilizer_speed)
		var current_transform = transform
		current_transform.basis = Basis(q)
		transform = current_transform
	
#	var joycmd = Vector2(Input.get_joy_axis(0, JOY_AXIS_0), Input.get_joy_axis(0, JOY_AXIS_1))
#	_turn_cmd = _turn_cmd.linear_interpolate(joycmd * 0.3, delta)
	
	# Damp orientation
	_turn_cmd *= Util.powv(Vector2(turn_damp, turn_damp), delta)
	
	# Move forward
	var current_speed = speed
	if Input.is_key_pressed(KEY_SHIFT):
		current_speed = current_speed / 4.0
	set_translation(pos + get_forward() * current_speed * delta)


func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			# Get mouse delta
			var motion = -event.relative_pos
			_turn_cmd += 0.01*motion
#	elif event.type == InputEvent.JOYSTICK_MOTION:
#		print(event.speed)




