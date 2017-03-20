
extends Node

export var capture_mouse = true

func _ready():
	if capture_mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.pressed and Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
			if capture_mouse:
				# Capture the mouse
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	elif event.type == InputEvent.KEY:
		if event.pressed and event.scancode == KEY_ESCAPE:
			# Get the mouse back
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

