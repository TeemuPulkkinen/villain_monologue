extends TextureButton

# Starts the game by loading the main scene
func _on_button_pressed():
	get_tree().change_scene_to_file("res://main_scene/main.tscn")
