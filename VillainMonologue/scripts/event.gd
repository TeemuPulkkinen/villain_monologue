extends Node

# Main scene tells where it is when it loads
var main
var sound_library

var current_malice = 20
var ended = false

# FUNCTIONS TO CALL FROM DIALOGUE:

# Play a sound from the current scene's sound library
func play_sound(sound : String):
	sound_library.get_node(sound).play()

func start_timer():
	main.start_timer()

func stop_timer():
	main.stop_timer()

func adjust_malice(amount):
	main.adjust_malice(amount)

func wake_up_hero():
	main.starting_cutscene_hero_lights()

func reveal_villain():
	main.starting_cutscene_villain_lights()

# Expressions
func hero_default():
	main.hero_default()

func hero_smug():
	main.hero_smug()

func hero_angry():
	main.hero_angry()


func kill_hero():
	main.kill_hero()
