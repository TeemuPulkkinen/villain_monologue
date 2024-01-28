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

var ending = false

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
	blackout.modulate.a = 1.0
	herolight1.hide()
	herolight2.hide()
	villain_shadow.rotation_degrees = 57.0
	# Start dialogue
	if !dialogue:
		DialogueManager.show_dialogue_balloon(dialogue_file, "dialogueRunner")
		dialogue = false

func starting_cutscene_hero_lights():
	var tween = create_tween()
	tween.tween_property(blackout, "modulate:a", 0.0, 2.0).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(herolight1.show).set_delay(0.1)
	tween.tween_callback(herolight2.show).set_delay(0.6)

func starting_cutscene_villain_lights():
	bg_unlit.hide()
	bg_unlit.modulate.a = 0.0
	var tween = create_tween().set_parallel()
	tween.tween_property(bg_unlit, "modulate:a", 1.0, 1.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property(villain_shadow, "rotation_degrees", 15, 1.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property(malice_progress_bar, "position:x", malice_progress_bar.position.x + 230, 1.0).set_trans(Tween.TRANS_BOUNCE)

# If A-key is pressed on the keyboard, adjusts the value of the progress bar
func adjust_malice(new_malice_value, positive):
	if positive:
		Event.play_sound("MaliceMeterUp")
	else:
		Event.play_sound("MaliceMeterDown")
	malice_progress_bar._adjust_malice_value(new_malice_value)

# Dialogue countdown timer functions
func start_timer():
	await timer.start_timer(timer_time)

func stop_timer():
	timer.stop_timer()
	
	
func end_game(max_evil):
	if ending: return
	ending = true
	get_node("ExampleBalloon").queue_free()
	await get_tree().create_timer(1.0).timeout
	if max_evil:
		Event.play_sound("EvilestLaugh")
		%LaughBg.show()
		%LaughVillain1.show()
		await get_tree().create_timer(2.0).timeout
		%LaughVillain2.show()
		%LaughVillain1.hide()
		await get_tree().create_timer(2.0).timeout
		%ButtonSmash1.show()
		await get_tree().create_timer(1.5).timeout
		%ButtonSmash2.show()
		await get_tree().create_timer(0.5).timeout
		%ButtonSmash3.show()
		await get_tree().create_timer(1.5).timeout
		blackout.show()
		blackout.modulate.a = 1.0
		await get_tree().create_timer(0.5).timeout
		Event.play_sound("Creak")
		await get_tree().create_timer(0.5).timeout
		Event.play_sound("Splash")
		await get_tree().create_timer(1.0).timeout
		Event.play_sound("Screaming")
		await get_tree().create_timer(0.2).timeout
		Event.play_sound("Omnom")
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://menus/credits_menu.tscn")
	else:
		Event.play_sound("Frustration")
		DialogueManager.show_dialogue_balloon(dialogue_file, "fail")
		return

func kill_hero():
	%ButtonSmash1.show()
	await get_tree().create_timer(1.5).timeout
	%ButtonSmash2.show()
	await get_tree().create_timer(1.5).timeout
	%ButtonSmash3.show()
	await get_tree().create_timer(1.5).timeout
	blackout.show()
	blackout.modulate.a = 1.0
	Event.play_sound("Creak")
	await get_tree().create_timer(0.5).timeout
	Event.play_sound("Splash")
	await get_tree().create_timer(1.0).timeout
	Event.play_sound("Screaming")
	await get_tree().create_timer(0.2).timeout
	Event.play_sound("Omnom")
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://menus/credits_menu.tscn")
