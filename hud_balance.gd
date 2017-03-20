tool
extends Node2D


func _ready():
	set_process(true)


func _process(delta):
	update()


func _draw():
	var len = 50
	
	#draw_circle(Vector2(0,0), len, Color(0,0,0, 0.5)) # BROKEN
	#draw_rect(Rect2(-Vector2(len,len), 2*Vector2(len, len)), Color(0,0,0, 0.5))
	
	var trans = get_parent().transform
	var up = trans.basis.y
	var right = trans.basis.x
	var forward = -trans.basis.z
	draw_line(Vector2(0,0), len*Vector2(right.x, -right.y), Color(1,0,0))
	draw_line(Vector2(0,0), len*Vector2(up.x, -up.y), Color(0,1,0))
	draw_line(Vector2(0,0), len*Vector2(forward.x, -forward.y), Color(0,0,1))
	
	var roll = 0
	if not get_tree().is_editor_hint():
		roll = get_parent().get_roll()
	
	var rollv = Vector2(cos(roll), sin(roll))
	draw_line(-rollv*len, rollv*len, Color(0.5, 0.5, 1))

