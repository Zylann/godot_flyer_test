
#static func lerp_angle(a, b, t):
#	if abs(a-b) >= PI:
#		if a > b:
#			a = normalize_angle(a) - 2.0 * PI
#		else:
#			b = normalize_angle(b) - 2.0 * PI
#	return lerp(a, b, t)
#
#
#static func normalize_angle(x):
#	return fposmod(x + PI, 2.0*PI) - PI


static func angle_to_fixed(a, b):
	var n = a.dot(b) / sqrt(a.length_squared() * b.length_squared())
	return acos(clamp(n, -1, 1))


static func damp(x, d):
	if x > 0.0:
		x -= d
		if x < 0.0:
			x = 0.0
	if x < 0.0:
		x += d
		if x > 0.0:
			x = 0.0
	return x

static func dampv(v, d):
	return Vector2(damp(v.x, d), damp(v.y, d))

static func deg2radv(v):
	return Vector2(deg2rad(v.x), deg2rad(v.y))

static func clampv(v, minv, maxv):
	return Vector2(clamp(v.x, minv.x, maxv.x), clamp(v.y, minv.y, maxv.y))

static func powv(v, p):
	return Vector2(pow(v.x, p), pow(v.y, p))



