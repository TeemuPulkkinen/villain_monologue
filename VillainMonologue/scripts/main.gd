extends Node2D

@export var timer_time = 10.0 ## Time allowed for dialogue responses

# Load some files and nodes
@onready var dialogue_file = load("res://dialogue.dialogue")
@onready var timer = %Timer
@onready var malice_progress_bar : TextureProgressBar = get_node("CanvasLayer/TextureProgressBar")
var dialogue = false
var ending = false

@onready var bg_unlit = %Background_Unlit
@onready var herolight1 = %HeroLight1
@onready var herolight2 = %HeroLight2
@onready var blackout = %Blackout
@onready var pows = %Pows


@onready var hero = %Hero
@onready var villain = %Villain
@onready var villain_shadow = villain.get_node("ColorRect")

var current_malice = 30
var malice_limits = [18, 33, 53, 76, 95]

# At start of game, play cutscene animations and then start dialogue
# Also et the TextureProgressBar in scene
func _ready():
	hero.hide()
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
	Event.play_sound("Laughter")
	await get_tree().create_timer(2.0).timeout
	# Start dialogue
	if !dialogue:
		DialogueManager.show_dialogue_balloon(dialogue_file, "dialogueRunner")
		dialogue = false

func starting_cutscene_hero_lights():
	get_node("ExampleBalloon").hide()
	var tween = create_tween().set_parallel()
	tween.tween_property(blackout, "modulate:a", 0.0, 2.0).set_trans(Tween.TRANS_QUART)
	tween.tween_callback(hero.show).set_delay(2.0)
	tween.tween_callback(hero.dangle_down).set_delay(2.0)
	tween.tween_callback(herolight1.show).set_delay(4.0)
	await tween.finished
	Event.play_sound("LampSnap")
	await get_tree().create_timer(1.0).timeout
	herolight2.show()
	Event.play_sound("LampSnap")
	await get_tree().create_timer(1.0).timeout
	get_node("ExampleBalloon").show()

func starting_cutscene_villain_lights():
	get_node("ExampleBalloon").hide()
	Event.play_sound("LampSnap")
	var tween = create_tween().set_parallel()
	tween.tween_property(bg_unlit, "modulate:a", 0.0, 2.0).set_trans(Tween.TRANS_SINE)
	tween.tween_property(villain_shadow, "rotation_degrees", 15, 1.0).set_trans(Tween.TRANS_SINE)
	tween.tween_property(malice_progress_bar, "position:x", malice_progress_bar.position.x + 230, 1.0).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	get_node("ExampleBalloon").show()

# If A-key is pressed on the keyboard, adjusts the value of the progress bar
func adjust_malice(amount):
	# see if we want a Pow
	var pow_display = check_malice_limits(amount)
	# Update malice
	current_malice += amount

	# Animate malice meter
	get_node("ExampleBalloon").hide()
	if amount > 0:
		Event.play_sound("MaliceMeterUp")
	else:
		Event.play_sound("MaliceMeterDown")
	await malice_progress_bar._adjust_malice_value(current_malice)
	
	# Display Pow if needed
	if pow_display:
		pows.display(pow_display)
		await get_tree().create_timer(3.0).timeout
	get_node("ExampleBalloon").show()
	
	if current_malice >= 100:
		end_game(true)
	elif current_malice <= 0:
		end_game(false)

# Check if malice passed a limit where we want to display a pow
func check_malice_limits(added_amount):
	var new_malice = current_malice + added_amount
	for i in range (0,malice_limits.size()):
		var limit = malice_limits[i]
		if (current_malice < limit && new_malice >= limit) or (current_malice >= limit && new_malice < limit):
			return i
		else:
			continue
		return null


# Dialogue countdown timer functions
func start_timer():
	await timer.start_timer(timer_time)

func stop_timer():
	timer.stop_timer()


func end_game(max_evil):
	Event.ended = true
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


# Expressions

func hero_smug():
	hero.smug()

func hero_angry():
	hero.angry()

func hero_default():
	hero.default()
