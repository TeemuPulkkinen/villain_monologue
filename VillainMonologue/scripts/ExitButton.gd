extends TextureButton

# Exits the game when the exit button is pressed.
func _on_pressed():
	Event.play_sound("Click")
	await get_parent().black_out()
	get_tree().quit()
