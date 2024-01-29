extends TextureButton

signal blackout

# Goes to main menu after game is over from credits scene
func _on_button_pressed():
	blackout.emit()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
