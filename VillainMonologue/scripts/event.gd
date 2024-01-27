extends Node

# Main scene tells where it is when it loads
var main
var sound_library

# FUNCTIONS TO CALL FROM DIALOGUE:

func start_timer():
	main.start_timer()

func stop_timer():
	main.stop_timer()

# Play a sound from the current scene's sound library
func play_sound(sound : String):
	sound_library.get_node(sound).play()

# Maximum evil reached, end game
func end_game_max_evil():
	# play bwahaha sound
	# play cutscene
	# -> credits
	print ("game ended with maximum evil meter")
