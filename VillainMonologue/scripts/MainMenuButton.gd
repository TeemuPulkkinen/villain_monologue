extends TextureButton

# Goes to main menu after game is over from credits scene
func _on_button_pressed():
	Event.play_sound("Click")
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
