extends Control


func _process(delta):
	# Quits game when Esc-key is pressed
	if Input.is_key_pressed(KEY_ESCAPE) :
		get_tree().quit()
