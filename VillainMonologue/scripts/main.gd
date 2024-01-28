extends Node2D

@export var timer_time = 10.0 ## Time allowed for dialogue responses

# Load some files and nodes
@onready var dialogue_file = load("res://dialogue.dialogue")
@onready var timer = %Timer
@onready var malice_progress_bar : TextureProgressBar = get_node("CanvasLayer/TextureProgressBar")
var dialogue = false

@onready var bg_unlit = %Background_Unlit
@onready var herolight1 = %HeroLight1
@onready var herolight2 = %HeroLight2
@onready var blackout = %Blackout

@onready var villain = %Villain
@onready var villain_shadow = villain.get_node("ColorRect")

# At start of game, play cutscene animations and then start dialogue
# Also et the TextureProgressBar in scene
func _ready():
	timer.hide()
	Event.main = self # Update Event on this node's location
	Event.sound_library = $SoundLibrary
	
	starting_cutscene()

func starting_cutscene():
	# Setup
	blackout.show()
	malice_progress_bar.position.x = malice_progress_bar.position.x - 230
	bg_unlit.show()
	blackout.modulate.a = 0.0
	herolight1.hide()
	bg_unlit.hide()
	villain_shadow.rotation_degrees = 69.0
	# Start dialogue
	if !dialogue:
		DialogueManager.show_dialogue_balloon(dialogue_file, "dialogueRunner")
		dialogue = false

func starting_cutscene_hero_lights():
	var tween = create_tween()
	tween.tween_property(blackout, "modulate:a", 1.0, 3.0).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(herolight1.show())
	
	

# If A-key is pressed on the keyboard, adjusts the value of the progress bar
func adjust_malice(new_malice_value):
	malice_progress_bar._adjust_malice_value(new_malice_value)

# Dialogue countdown timer functions
func start_timer():
	await timer.start_timer(timer_time)
	# autoselect one of the dialogue options
	# TO DO

func stop_timer():
	timer.stop_timer()
