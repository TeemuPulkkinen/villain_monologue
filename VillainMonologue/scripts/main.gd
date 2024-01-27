extends Node2D

<<<<<<< HEAD
# When scene loads, get the TextureProgressBar in scene
func _ready():
	var malice_progress_bar : TextureProgressBar = get_node("CanvasLayer/TextureProgressBar")

# If A-key is pressed on the keyboard, adjusts the value of the progress bar
func _increase_malice(malice_progress_bar):
	if Input.is_key_pressed(KEY_A):
		var new_malice_value = malice_progress_bar.value + 20
		malice_progress_bar._adjust_malice_value(new_malice_value)
	if Input.is_key_pressed(KEY_A) && malice_progress_bar.value == 100:
		var new_malice_value = malice_progress_bar.value - 10
		malice_progress_bar._adjust_malice_value(new_malice_value)

# Calls the _increase_malice function every frame
func _process(delta):
	var malice_progress_bar : TextureProgressBar = get_node("CanvasLayer/TextureProgressBar")
	_increase_malice(malice_progress_bar)
=======
@export var timer_time = 10.0 ## Time allowed for dialogue responses

# Load some files and nodes
@onready var dialogue_file = load("res://dialogue.dialogue")
@onready var timer = %Timer
var dialogue = false

# At start of game, play cutscene animations and then start dialogue
func _ready():
	timer.hide()
	Event.main = self # Update Event on this node's location
	Event.sound_library = $SoundLibrary
	# Start cutscene
	# TO DO
	
	# Start dialogue
	if !dialogue:
		DialogueManager.show_dialogue_balloon(dialogue_file, "start1")
		dialogue = false

func start_timer():
	await timer.start_timer(timer_time)
	# autoselect one of the dialogue options
	# TO DO

func stop_timer():
	timer.stop_timer()
>>>>>>> Mosus_event_and_dialogue
