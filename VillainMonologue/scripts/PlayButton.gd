extends TextureButton

# Starts the game by loading the main scene
func _on_button_pressed():
	Event.play_sound("Click")
	await get_parent().black_out()
	get_tree().change_scene_to_file("res://main_scene/main.tscn")
