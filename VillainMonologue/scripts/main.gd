extends Node2D

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
