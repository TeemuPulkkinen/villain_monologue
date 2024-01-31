extends Node

# Main scene tells where it is when it loads
var main
var sound_library
var icon_library = {}

var current_malice = 20
var ended = false

# LOAD RESOURCES FOR ICONS
func _ready():
	var dir = DirAccess.open("res://art/option_icons/")
	dir.list_dir_begin()
	var filename = dir.get_next()
	while (filename != ""):
		if filename.ends_with(".png"):
			filename = filename.replace('.import', '')
			icon_library[filename.left(filename.length()-4)] = load("res://art/option_icons/" + filename)
		filename = dir.get_next()

# Turn icon name into texture file
func get_icon(icon_name):
	return icon_library["option_"+icon_name]


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

func villain_default():
	main.villain_default()

func villain_distraught():
	main.villain_distraught()

func villain_ecstatic():
	main.villain_ecstatic()

func villain_frustrated():
	main.villain_frustrated()

func villain_gleeful():
	main.villain_gleeful()


func kill_hero():
	main.kill_hero()

func go_credits():
	main.go_credits()
