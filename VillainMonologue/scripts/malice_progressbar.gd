extends TextureProgressBar


#Function for adjusting the malice meter, input is malice value after player choice is made
func _adjust_malice_value(new_malice_value):
	# Create new Tween
	var tween = get_tree().create_tween()
	# Animates the progress bar to the new malice value over the time of 1 second
	tween.tween_property(self, "value", new_malice_value, 1.0)
