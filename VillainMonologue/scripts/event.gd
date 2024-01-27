extends Node

# Main scene tells where it is when it loads
var main
var sound_library

var current_malice = 20

# FUNCTIONS TO CALL FROM DIALOGUE:

func start_timer():
	main.start_timer()

func stop_timer():
	main.stop_timer()

func adjust_malice(amount):
	current_malice += amount
	main.adjust_malice(current_malice)
	
	if current_malice >= 100:
		end_game_max_evil()
	elif current_malice <= 0:
		end_game_max_nice()


# Play a sound from the current scene's sound library
func play_sound(sound : String):
	sound_library.get_node(sound).play()

# Maximum evil reached, end game
func end_game_max_evil():
	# play bwahaha sound
	# play cutscene
	# -> credits
	print ("game ended with maximum evil meter")

func end_game_max_nice():
	print ("game ended with no evil. sad")
