extends Node3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
