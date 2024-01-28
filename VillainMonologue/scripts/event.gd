extends Node

# Main scene tells where it is when it loads
var main
var sound_library

var current_malice = 20
var ended = false

# FUNCTIONS TO CALL FROM DIALOGUE:

func start_timer():
	main.start_timer()

func stop_timer():
	main.stop_timer()

func adjust_malice(amount):
	current_malice += amount
	var positive
	if amount > 0:
		positive = true
	else: positive = false
	main.adjust_malice(current_malice, positive)
	
	if current_malice >= 100:
		end_game_max_evil()
	elif current_malice <= 0:
		end_game_max_nice()

func wake_up_hero():
	main.starting_cutscene_hero_lights()

func reveal_villain():
	main.starting_cutscene_villain_lights()


# Play a sound from the current scene's sound library
func play_sound(sound : String):
	sound_library.get_node(sound).play()

# Maximum evil reached, end game
func end_game_max_evil():
	ended = true
	main.end_game(true)

func end_game_max_nice():
	ended = true
	main.end_game(false)

func kill_hero():
	main.kill_hero()
