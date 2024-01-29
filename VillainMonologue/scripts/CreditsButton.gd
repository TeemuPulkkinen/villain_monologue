extends TextureButton

func _on_pressed():
	Event.play_sound("Click")
	get_tree().change_scene_to_file("res://menus/credits_menu.tscn")
