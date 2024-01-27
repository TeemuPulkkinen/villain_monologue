extends Node2D

# When scene loads, get the TextureProgressBar in scene
func _ready():
	var malice_progress_bar : TextureProgressBar = get_node("CanvasLayer/TextureProgressBar")

# If A-key is pressed on the keyboard, adjusts the value of the progress bar
func _increase_malice(malice_progress_bar):
	if Input.is_key_pressed(KEY_A):
		var new_malice_value = malice_progress_bar.value + 20
		malice_progress_bar._adjust_malice_value(new_malice_value)
	if Input.is_key_pressed(KEY_A) && malice_progress_bar.value == 100:
		var new_malice_value = malice_progress_bar.value - 10
		malice_progress_bar._adjust_malice_value(new_malice_value)

# Calls the _increase_malice function every frame
func _process(delta):
	var malice_progress_bar : TextureProgressBar = get_node("CanvasLayer/TextureProgressBar")
	_increase_malice(malice_progress_bar)
