extends Control

signal blackout

@onready var line1_lyrics = $Line1Lyrics
@onready var line1_progress = $Line1Progress
@onready var line1_sung = line1_progress.get_node("Line1SungLyrics")

var base_line_duration : float = 1.8

func _ready():
	await tween_current_lines(base_line_duration, 30)
	line("He will hunt you down")
	await tween_current_lines(base_line_duration, 10)
	line("He is evil")
	await tween_current_lines(base_line_duration, 30)
	line("He will look for you in town")
	await tween_current_lines(base_line_duration, 10)
	line("He is evil")
	await tween_current_lines(base_line_duration, 30)
	line("He will do his evil deeds")
	await tween_current_lines(base_line_duration, 10)
	line("He is evil")
	await tween_current_lines(base_line_duration, 30)
	line("He will have you on your knees")
	await tween_current_lines()
	line("He's the evilest of evil")
	await tween_current_lines(2.0, 10)
	line("And he will kill you dead")
	await tween_current_lines(2.0, 10)
	line("He's the badmost of the bad boys")
	await tween_current_lines(2.0)
	line("And he'll fill your heart with dread")
	await tween_current_lines(2.0)
	line("He is evil")
	await tween_current_lines(base_line_duration, 30)
	line("He is bad to the bone")
	await tween_current_lines(base_line_duration, 10)
	line("He is evil")
	await tween_current_lines(base_line_duration, 30)
	line("And he hates to be alone")
	await tween_current_lines(3.0, 10)
	blackout.emit()
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
	

func tween_current_lines(duration := base_line_duration, offset := 0.0):
	line1_progress.value = offset
	var tween = create_tween()
	tween.tween_property(line1_progress, "value", 100-offset, duration)
	return tween.finished

func line(this_line:String):
	line1_lyrics.text = "[center]"+this_line
	line1_sung.text = "[center]"+this_line
