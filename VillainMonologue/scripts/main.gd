extends Node2D

@export var timer_time = 10.0 ## Time allowed for dialogue responses

# Load some files and nodes
@onready var dialogue_file = load("res://dialogue.dialogue")
@onready var timer = %Timer
@onready var malice_progress_bar : TextureProgressBar = get_node("CanvasLayer/TextureProgressBar")
var dialogue = false

# At start of game, play cutscene animations and then start dialogue
# Also et the TextureProgressBar in scene
func _ready():
	timer.hide()
	Event.main = self # Update Event on this node's location
	Event.sound_library = $SoundLibrary
	# Start cutscene
	# TO DO
	
	# Start dialogue
	if !dialogue:
		DialogueManager.show_dialogue_balloon(dialogue_file, "dialogueRunner")
		dialogue = false

## If new_malice_value is positive, play the sound for increasing malice meter, if negative, play reducing malice meter
func adjust_malice(new_malice_value, positive):
	if positive == true:
		Event.play_sound("MaliceMeterUp")
	else:
		Event.play_sound("MaliceMeterDown")
	malice_progress_bar._adjust_malice_value(new_malice_value)

# Dialogue countdown timer functions
func start_timer():
	await timer.start_timer(timer_time)
	# autoselect one of the dialogue options
	# TO DO

func stop_timer():
	timer.stop_timer()
